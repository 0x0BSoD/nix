{inputs, ...}: let
  darwinPath = "../../../modules/darwin/system";
  appsPath = "../../../modules/common/user";
in {
  imports = [
    inputs.nixvim.nixDarwinModules.nixvim

    ../../../modules/common/home-manager-defaults.nix

    ./${darwinPath}/nix.nix
    ./${darwinPath}/pam.nix
    ./${darwinPath}/system.nix
    ./${darwinPath}/security.nix
    ./${darwinPath}/fonts.nix
    ./${appsPath}/neovim.nix

    ./homebrew.nix
  ];
}
