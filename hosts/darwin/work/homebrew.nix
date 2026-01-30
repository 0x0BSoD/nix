{
  primaryUser,
  inputs,
  config,
  ...
}: {
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    mutableTaps = true;
    user = primaryUser;

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

    taps = builtins.attrNames config.nix-homebrew.taps;

    casks = [
      "ghostty"
      "docker-desktop"
      "displaylink"
      {
        name = "chatgpt";
        greedy = true;
      }
    ];

    brews = [
      "coreutils"
      "docker-compose"
      "helm"
      "pinentry-mac"
      "x86_64-unknown-linux-gnu"
    ];
  };
}
