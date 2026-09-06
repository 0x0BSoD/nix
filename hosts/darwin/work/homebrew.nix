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
      "chatgpt"
      "claude-code"
      "codex"
      "docker-desktop"
      "ghostty"
      "obsidian"
    ];

    brews = [
      "asciiquarium"
      "coreutils"
      "docker-compose"
      "helm"
      "pinentry-mac"
    ];
  };
}
