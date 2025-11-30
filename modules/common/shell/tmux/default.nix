{pkgs, ...}: let
  nord-theme =
    pkgs.tmuxPlugins.mkTmuxPlugin
    {
      pluginName = "nord";
      version = "0.3.0";
      rtpFilePath = "nord.tmux";
      src = pkgs.fetchFromGitHub {
        owner = "nordtheme";
        repo = "tmux";
        rev = "f7b6da07ab55fe32ee5f7d62da56d8e5ac691a92";
        hash = "sha256-mcmVYNWOUoQLiu4eM/EUudRg67Gcou13xuC6zv9aMKA=";
      };
    };
in {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 20000;
    keyMode = "vi";

    plugins = [
      nord-theme
    ];

    extraConfig = builtins.readFile ./tmux.conf;
  };
}
