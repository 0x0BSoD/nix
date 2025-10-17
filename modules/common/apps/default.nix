{ pkgs, ... }:

{

  imports = [
    ./bat.nix
    ./btop.nix
    ./fzf.nix
    ./git.nix
    ./alacritty.nix
  ];

  home.packages = with pkgs; [
    bottom
    curlie
    delta
    dog
    duf
    dust
    fd
    fx
    gawk
    gnupg
    jq
    k9s
    kubecolor
    kubectl
    kubectx
    lsd
    neovim
    nil
    nixd
    pinentry_mac
    procs
    ripgrep
    starship
    stern
    viddy
    yq
    zoxide
  ];
}
