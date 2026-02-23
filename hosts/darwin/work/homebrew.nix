{
  primaryUser,
  inputs,
  config,
  ...
}: {
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    mutableTaps = false;
    user = primaryUser;

    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
      "sergiobenitez/osxct" = inputs.sergioBenitez-osxct;
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
      "claude-code"
      {
        name = "chatgpt";
        greedy = true;
      }
      "displaylink"
      "docker-desktop"
      "ghostty"
      "headlamp"
      "qmk-toolbox"
      "virtualbox"
    ];

    brews = [
      "coreutils"
      "docker-compose"
      "gwctl"
      "helm"
      "pinentry-mac"
      "snitch"
      "x86_64-unknown-linux-gnu"
    ];
  };
}
