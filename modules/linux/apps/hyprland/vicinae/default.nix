{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.vicinae.homeManagerModules.default];

  services.vicinae = {
    enable = true;
    autoStart = true;
  };

  xdg.configFile."vicinae/vicinae.json".source = lib.mkForce ./vicinae.json;
  xdg.configFile."vicinae/themes/gruvbox-dark-hard.json".source = ./gruvbox-dark-hard.json;
}
