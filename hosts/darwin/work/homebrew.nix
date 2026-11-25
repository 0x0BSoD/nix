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
    };
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };

    global = {
      brewfile = true;
      autoUpdate = false;
    };

    taps = builtins.attrNames config.nix-homebrew.taps;

    brews = [
      "clusterctl"
      "gh"
      "glab"
    ];

    casks = [
      "caffeine"
      "docker-desktop"
      "ollama-app"
    ];
  };
}
