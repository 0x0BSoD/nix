{pkgs, ...}: {
  home.packages = with pkgs; [
    rofi
    qogir-icon-theme
    qogir-theme
    imv
    lowfi
    mpv
    wl-clipboard
    xdg-utils
    banana-cursor
    asciiquarium-transparent
    cbonsai
    cmatrix
    countryfetch
    cowsay
    figlet
    fortune
    lavat
    lolcat
    pipes
    sl
    tty-clock
    wine
    libgcc
    gcc
  ];
}
