{inputs, ...}: {
  imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

  services.flatpak = {
    enable = true;
    packages = [
      "com.github.tchx84.Flatseal"
      "dev.zed.Zed"
    ];
    overrides = {
      global = {
        Context.sockets = [
          "wayland"
          "!x11"
          "!fallback-x11"
        ];
      };
      "dev.zed.Zed" = {
         Environment = {
           ZED_FLATPAK_NO_ESCAPE = "1";
         };
       };
    };
  };
}
