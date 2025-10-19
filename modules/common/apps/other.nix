{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    bottom
    curlie
    dog
    duf
    dust
    fd
    fx
    gawk
    gnupg
    go
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
    # spotify
    chatgpt
    chatgpt-cli
    stern
    viddy
    yq
    zoxide
  ];
}
