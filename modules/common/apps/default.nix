{ pkgs, ... }:

{

  imports = [
    ./bat.nix
    ./btop.nix
    ./fzf.nix
    ./git.nix
    # ./ghostty.nix
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
    jq
    k9s
    kubecolor
    kubectl
    kubectx
    lsd
    neovim
    procs
    ripgrep
    starship
    stern
    viddy
    yq
    zoxide
  ];
}
