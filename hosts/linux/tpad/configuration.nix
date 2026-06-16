{
  self,
  pkgs,
  ...
}: let
  linuxPath = "${self}/modules/linux/system";
in {
  networking = {
    hostName = "tpad";
    networkmanager.enable = true;
  };

  fileSystems = {
    "/".options = ["compress=zstd"];
    "/home".options = ["compress=zstd"];
    "/nix".options = ["compress=zstd" "noatime"];
    "/mnt/nas/downloads" = {
      device = "//172.16.1.3/Downloads";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.mount-timeout=5s,uid=1000";
      in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
    };
    "/mnt/nas/documents" = {
      device = "//172.16.1.3/Documents";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.mount-timeout=5s,uid=1000";
      in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
    };
  };

  environment.systemPackages = with pkgs; [
    acpi
    brightnessctl
    powertop
  ];

  imports = [
    ./../common.nix
    ./hardware-configuration.nix

    "${self}/modules/common/home-manager-defaults.nix"

    "${linuxPath}/bluetooth.nix"
    "${linuxPath}/boot.nix"
    "${linuxPath}/fingerprint-scanner.nix"
    "${linuxPath}/locale.nix"
    "${linuxPath}/video.nix"

    "${linuxPath}/flatpak.nix"
    "${linuxPath}/fonts.nix"
    "${linuxPath}/nix.nix"
    "${linuxPath}/security.nix"
    "${linuxPath}/services.nix"
    "${linuxPath}/steam.nix"
    "${linuxPath}/wayland.nix"
  ];
}
