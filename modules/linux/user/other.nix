{pkgs, ...}: {
  home.packages = with pkgs; [
    conda
    direnv
    gcc
    glib
    libgcc
    pigz
    rofi
    swww
    unzip
    wine
    xdg-utils
    claude-code
    aider-chat-full
    opencode
    cmake
    openssl

    # Nord theme packages
    nordic
    nordzy-icon-theme
    nordzy-cursor-theme
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    adwaita-qt

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

    # GUI devel
    xorg.libX11.dev
    xorg.libXcursor
    xorg.libXi
    xorg.libXinerama
    xorg.libXrandr
    xorg.libXxf86vm
    libxkbcommon
    libGL

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
