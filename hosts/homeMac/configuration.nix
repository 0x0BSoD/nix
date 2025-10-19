{...}: {
  nixpkgs.config.allowUnfree = true;
  imports = [
    ../../modules/darwin
  ];
}
