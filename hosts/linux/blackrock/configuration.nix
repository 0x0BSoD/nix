{...}: let
  linuxPath = "../../../modules/linux";
in {
  networking = {
    hostName = "blackrock";
    networkmanager.enable = true;
  };

  imports = [
    ./hardware-configuration.nix

    ./${linuxPath}/boot.nix
    ./${linuxPath}/locale.nix
    ./${linuxPath}/video.nix

    ./${linuxPath}/flatpak.nix
    ./${linuxPath}/fonts.nix
    ./${linuxPath}/nix.nix
    ./${linuxPath}/security.nix
    ./${linuxPath}/services.nix
    ./${linuxPath}/steam.nix
    ./${linuxPath}/wayland.nix
  ];
}
