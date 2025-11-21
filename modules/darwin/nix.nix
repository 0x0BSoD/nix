{...}: {
  launchd.daemons."org.nixos.nix-daemon".serviceConfig = {
    SoftResourceLimits = {
      NumberOfFiles = 1048576;
    };
    HardResourceLimits = {
      NumberOfFiles = 1048576;
    };
  };
  nix = {
    enable = false;
    settings.experimental-features = "nix-command flakes";
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
  };
}
