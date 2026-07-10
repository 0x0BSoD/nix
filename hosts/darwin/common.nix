{self, ...}: let
  darwinPath = "${self}/modules/darwin/system";
in {
  imports = [
    "${self}/modules/common/home-manager-defaults.nix"

    "${darwinPath}/nix.nix"
    "${darwinPath}/system.nix"
    "${darwinPath}/launchd.nix"
    "${darwinPath}/security.nix"
    "${darwinPath}/fonts.nix"
  ];
}
