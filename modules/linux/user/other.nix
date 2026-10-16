{pkgs, ...}: {
  home.packages = with pkgs; [
    awww
    cmake
    conda
    direnv
    gcc
    glib
    libgcc
    opencode
    openssl
    pigz
    rpi-imager
    socat
    transmission_4-qt
    unzip
    xdg-utils

    # claude-code
    # codex
    # aider-chat-full

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
    # for pactl
    pulseaudio
    wiremix

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
    libx11.dev
    libxcursor
    libxi
    libxinerama
    libxrandr
    libxxf86vm
    libxkbcommon
    libGL
    kdePackages.qtdeclarative

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
