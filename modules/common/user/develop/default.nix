{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./java.nix
  ];

  # Global pkg-config search path for cgo builds (e.g. getlantern/systray),
  # instead of per-project dev shells. pkg-config resolves Requires: chains,
  # so the whole public dep chain must be here — if a build fails with
  # "Package 'X' was not found", append the package that ships X.pc.
  home.sessionVariables = lib.optionalAttrs pkgs.stdenv.isLinux {
    PKG_CONFIG_PATH = let
      devs = map lib.getDev (with pkgs; [
        libayatana-appindicator
        libayatana-indicator
        libayatana-indicator
        ayatana-ido
        libdbusmenu-gtk3
        gtk3
        glib
        gdk-pixbuf
        cairo
        pango
        atk
        harfbuzz
        zlib
      ]);
      # .pc files live in lib/pkgconfig for most packages, share/pkgconfig
      # for headers-only ones (e.g. zlib) — search both.
    in
      lib.concatStringsSep ":" [
        (lib.makeSearchPath "lib/pkgconfig" devs)
        (lib.makeSearchPath "share/pkgconfig" devs)
      ];

    # libayatana-indicator's .pc lacks -L${libdir} in Libs (upstream bug),
    # so the linker never learns its path — pass it explicitly for cgo.
    CGO_LDFLAGS = "-L${lib.getLib pkgs.libayatana-indicator}/lib";
  };

  home.packages = with pkgs; [
    # nix
    alejandra
    nil
    nixd

    # go
    go
    gopls
    gofumpt
    kubebuilder
    delve
    protoc-gen-go-grpc
    protobuf

    # rust
    cargo
    rustc
    rustfmt
    rust-analyzer
    clippy

    # python
    python314
    ruff
    uv

    # nodejs
    nodejs_24

    # tools
    pkg-config
    helm-ls
    shellcheck
    shfmt
    stylua
    gnumake
  ];
}
