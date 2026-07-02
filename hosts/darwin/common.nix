{
  self,
  inputs,
  ...
}: let
  darwinPath = "${self}/modules/darwin/system";
  appsPath = "${self}/modules/common/user";
in {
  imports = [
    inputs.nixvim.nixDarwinModules.nixvim

    "${self}/modules/common/home-manager-defaults.nix"

    "${darwinPath}/nix.nix"
    "${darwinPath}/system.nix"
    "${darwinPath}/launchd.nix"
    "${darwinPath}/security.nix"
    "${darwinPath}/fonts.nix"
    "${appsPath}/neovim.nix"
  ];
}
