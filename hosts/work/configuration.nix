{...}: {
  nixpkgs.config.allowUnfree = true;
  imports = [
    ../../modules/darwin
    ../../modules/common/homebrew
  ];
}
