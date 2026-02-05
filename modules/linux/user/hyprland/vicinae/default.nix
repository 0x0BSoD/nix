{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.vicinae.homeManagerModules.default];

  services.vicinae = {
    enable = true;
    systemd = {
      autoStart = true;
    };

    settings = {
      close_on_focus_loss = true;
      consider_preedit = true;
      pop_to_root_on_close = true;
      favicon_service = "twenty";
      search_files_in_root = true;
      font = {
        normal = {
          size = 12;
          normal = "Maple Nerd Font";
        };
      };
      theme = {
        light = {
          name = "nord-light";
          icon_theme = "nord";
        };
        dark = {
          name = "nord";
          icon_theme = "nord";
        };
      };
      launcher_window = {
        opacity = 0.98;
      };
    };
    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
      bluetooth
      nix
      power-profile
    ];
  };
}
