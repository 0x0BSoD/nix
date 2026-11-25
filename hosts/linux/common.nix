{pkgs, ...}: {
  system.stateVersion = "26.05";

  environment.systemPackages = [pkgs.bubblewrap];

  # Rootless: daemon runs as the user, no root-equivalent docker group.
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

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
