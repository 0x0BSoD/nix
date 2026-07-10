{...}: {
  # nix-darwin does not manage the Nix installation itself; the Nix daemon
  # config (flakes, experimental-features, etc.) lives in /etc/nix/nix.conf
  # written by the Nix installer, outside this repo.
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;
}
