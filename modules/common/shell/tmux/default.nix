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
  # tmux-dark-notify =
  #   pkgs.tmuxPlugins.mkTmuxPlugin
  #   {
  #     pluginName = "tmux-dark-notify";
  #     version = "v0.1.1";
  #     rtpFilePath = "main.tmux";
  #     src = pkgs.fetchFromGitHub {
  #       owner = "erikw";
  #       repo = "tmux-dark-notify";
  #       rev = "dfa2b45b3edab2fbd6961bdb40b2a7c50fc17060";
  #       sha256 = "sha256-naOIotyAgUHZ2qSPmvLMkxGeU0/vfQYrFPjO7Coig0g=";
  #     };
  #   };
in {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 20000;
    keyMode = "vi";

    plugins = [
      nord-theme
      # {
      #   plugin = tmux-dark-notify;
      #   extraConfig = ''
      #     set -g @dark-notify-theme-path-light '$HOME/.config/tmux/plugins/tmux-colors-solarized/tmuxcolors-light.conf'
      #     set -g @dark-notify-theme-path-dark '$HOME/.config/tmux/plugins/tmux-colors-solarized/tmuxcolors-dark.conf'
      #   '';
      # }
    ];

    extraConfig = builtins.readFile ./tmux.conf;
  };
}
