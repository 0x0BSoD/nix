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
    ./statusline.nix
    ./theme.nix
    ./tmux.nix
  ];

  programs.claude-code = {
    enable = true;
    package = claude.claude-code;
    settings = {
      enabledPlugins = {
        "k8s-decommission@agents-marketplace" = true;
        "capi-cluster@agents-marketplace" = true;
        "k8s-hosts@agents-marketplace" = true;
        "lb-dns@agents-marketplace" = true;
        "lb-mr@agents-marketplace" = true;
        "redis@agents-marketplace" = true;
      };
    };
  };

  home.packages = lib.optional pkgs.stdenv.hostPlatform.isDarwin claude.claude-desktop;
}
