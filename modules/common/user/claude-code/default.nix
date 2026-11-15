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
    ./kubernetes-mcp.nix
    ./plugins.nix
    ./theme.nix
    ./tmux.nix
  ];

  programs.claude-code = {
    enable = true;
    package = claude.claude-code;
  };

  home.packages = lib.optional pkgs.stdenv.hostPlatform.isDarwin claude.claude-desktop;
}
