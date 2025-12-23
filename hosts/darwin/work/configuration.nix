{...}: let
  darwinPath = "../../../modules/darwin";
in {
  imports = [
    ./${darwinPath}/nix.nix
    ./${darwinPath}/pam.nix
    ./${darwinPath}/system.nix
    ./${darwinPath}/security.nix
    ./${darwinPath}/fonts.nix

    ./homebrew.nix
  ];
}
