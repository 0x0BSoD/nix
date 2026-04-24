{pkgs, ...}: {
  home.packages = with pkgs; [
    bottom
    curlie
    dig
    duf
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
    yazi
    yq
  ];
}
