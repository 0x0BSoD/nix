{pkgs, ...}: {
  system.stateVersion = "25.11";

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
