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

  # NAS mounts need /etc/nixos/smb-secrets to exist (not managed by Nix).
  # Create it manually on a fresh install:
  #   username=<smb user>
  #   password=<smb password>
  fileSystems = {
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

  # hosts/linux/common.nix is imported by the flake (host registry), not here.
  imports = [
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
