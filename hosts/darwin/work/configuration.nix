{inputs, ...}: let
  darwinPath = "../../../modules/darwin";
  appsPath = "../../../modules/common/apps";
in {
  imports = [
    inputs.nixvim.nixDarwinModules.nixvim

    ./${darwinPath}/nix.nix
    ./${darwinPath}/pam.nix
    ./${darwinPath}/system.nix
    ./${darwinPath}/security.nix
    ./${darwinPath}/fonts.nix
    ./${appsPath}/neovim.nix

    ./homebrew.nix
  ];
}
