{...}: let
  linuxPath = "../../../modules/linux";
in {
  networking = {
    hostName = "blackrock";
    networkmanager.enable = true;
  };

  fileSystems = {
    "/mnt/nas/downloads" = {
      device = "//10.1.1.3/Downloads";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.mount-timeout=5s,uid=1000";
      in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
    };
    "/mnt/nas/documents" = {
      device = "//10.1.1.3/Documents";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.mount-timeout=5s,uid=1000";
      in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
    };
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
