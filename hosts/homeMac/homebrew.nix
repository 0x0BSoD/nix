{
  primaryUser,
  inputs,
  ...
}: {
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = primaryUser;
    autoMigrate = true;
    mutableTaps = true;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "SergioBenitez/osxct" = inputs.sergioBenitez-osxct;
    };
  };

  homebrew = {
    enable = true;
    casks = [
      "ghostty"
    ];
    brews = [
      "x86_64-unknown-linux-gnu"
    ];
  };
}
