{
  inputs,
  lib,
  pkgs,
  ...
}: let
  claude = inputs.claude.packages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [
    ./hindsight.nix
  ];

  programs.claude-code = {
    enable = true;
    package = claude.claude-code;

    settings = {
      theme = "auto";
    };
  };

  home.packages = lib.optional pkgs.stdenv.hostPlatform.isDarwin claude.claude-desktop;
}
