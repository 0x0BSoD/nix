{pkgs, ...}: {
  home.packages = with pkgs; [
    direnv
    gcc
    glib
    libgcc
    rofi
    swww
    unzip
    wine
    xdg-utils

    # media
    mpv
    lowfi
    imv
    playerctl

    # wayland
    cliphist
    grim
    grimblast
    hyprpicker
    slurp
    wayland
    wf-recorder
    wl-clip-persist
    wl-clipboard

    # fun stuff
    # asciiquarium-transparent
    # cbonsai
    # cmatrix
    # countryfetch
    # cowsay
    # figlet
    # fortune
    # lavat
    # lolcat
    # pipes
    # sl
    # tty-clock
  ];
}
