{
  primaryUser,
  inputs,
  ...
}: {
  nix-homebrew = {
    enable = true;

    enableRosetta = false;
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

    # Weird side-effect of using nix-homebrew pinning is that what's below needs to be duplicated in the flake
    # or possibly I can get rid of this...
    # but I think it needs to be the same, though I might have to activate the system with the new tap in the flake before adding it here? ugh.
    taps = [
      "homebrew/core"
      "homebrew/cask"
      "SergioBenitez/osxct"
    ];

    casks = [
      "ghostty"
      "docker-desktop"
      "displaylink"
    ];
    brews = [
      "x86_64-unknown-linux-gnu"
    ];
  };
}
