{pkgs, ...}: {
  system.stateVersion = "25.11";

  fileSystems = {
    "/".options = ["compress=zstd"];
    "/home".options = ["compress=zstd"];
    "/nix".options = ["compress=zstd" "noatime"];
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

  virtualisation.docker.enable = true;

  programs = {
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        openssl
      ];
    };
  };
}
