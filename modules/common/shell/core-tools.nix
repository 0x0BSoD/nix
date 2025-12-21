{pkgs, ...}: {
  home.packages = with pkgs; [
    curlie
    duf
    bottom
    dust
    fd
    fx
    gawk
    gnupg
    jq
    lsd
    procs
    ripgrep
    viddy
    yq
    yazi
  ];
}
