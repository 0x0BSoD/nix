{
  pkgs,
  inputs,
  ...
}: let
  nvimPkg = inputs.neovim-flake.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  home.packages = [
    nvimPkg
  ];
}
