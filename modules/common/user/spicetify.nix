{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "frappe";
    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
      history
    ];
  };
}
