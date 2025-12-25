{
  primaryUser,
  inputs,
  ...
}: {
  nix-homebrew = {
    enable = true;

    enableRosetta = true;
    user = primaryUser;
    autoMigrate = false;
    mutableTaps = true;

    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "SergioBenitez/osxct" = inputs.sergioBenitez-osxct;
    };
  };

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    onActivation = {
      autoUpdate = false;
      upgrade = true;
      cleanup = "uninstall";
    };
    global = {
      brewfile = true;
      autoUpdate = false;
    };
    taps = [
      "homebrew/core"
      "homebrew/cask"
      "SergioBenitez/osxct"
    ];

    casks = [
      # "cutter" # Reverse
      "binary-ninja-free"
      "ghostty"
      "blackhole-16ch"
    ];

    brews = [
      # "radare2" # Reverse
      "x86_64-unknown-linux-gnu"
      "binwalk"
      "portaudio"
    ];
  };
}
