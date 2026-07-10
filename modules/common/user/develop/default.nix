{pkgs, ...}: {
  imports = [
    ./java.nix
  ];

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
    helm-ls
    shellcheck
    shfmt
    stylua
    gnumake
  ];
}
