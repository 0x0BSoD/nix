{pkgs, ...}: let
  linuxPath = "../../../modules/linux";
in {
  networking = {
    hostName = "tpad";
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    acpi
    brightnessctl
    cpupower-gui
    powertop
  ];

  imports = [
    ./hardware-configuration.nix

    ./${linuxPath}/bluetooth.nix
    ./${linuxPath}/boot.nix
    ./${linuxPath}/fingerprint-scanner.nix
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
