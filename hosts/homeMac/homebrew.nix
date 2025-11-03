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
    mutableTaps = false;

    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
  };
  homebrew = {
    enable = true;
    casks = [];
  };
}
