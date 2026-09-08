{pkgs, ...}: {
  system.stateVersion = "26.05";

  virtualisation.docker.enable = true;

  programs = {
    nh.enable = true;
    dconf.enable = true;
    neovim.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        openssl
        alsa-lib
      ];
    };
  };
}
