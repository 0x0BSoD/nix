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

  tmux-spotify-info =
    if pkgs.stdenv.isDarwin
    then
      pkgs.stdenvNoCC.mkDerivation {
        pname = "tmux-spotify-info";
        version = "1.0.4";

        src = pkgs.fetchFromGitHub {
          owner = "jaclu";
          repo = "tmux-spotify-info";
          rev = "1998e9a69cf028c4b507d1bf7516f5a8d3868065";
          hash = "sha256-g3P+1C/d9CBVdDkp+K5Pg55QpLVrSxY1df3rF526Kmo=";
        };

        installPhase = ''
          runHook preInstall
          install -Dm755 tmux-spotify-info $out/bin/tmux-spotify-info
          runHook postInstall
        '';
      }
    else
      pkgs.writeShellScriptBin "tmux-spotify-info" ''
        status="$(${pkgs.playerctl}/bin/playerctl --player=spotify status 2>/dev/null || true)"
        [ "$status" = "Playing" ] || exit 0

        ${pkgs.playerctl}/bin/playerctl --player=spotify metadata \
          --format '{{title}} - {{artist}} - {{album}}' 2>/dev/null \
          | ${pkgs.coreutils}/bin/cut -c 1-60
      '';
in {
  home.packages = [
    tmux-spotify-info
  ];

  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 20000;
    keyMode = "vi";

    plugins = [
      nord-theme
    ];

    extraConfig = ''
      ${builtins.readFile ./tmux.conf}
      set-option -g status-left-length 200
      set -g status-left "#[fg=black,bg=blue,bold] 🎧#(${tmux-spotify-info}/bin/tmux-spotify-info) #[fg=blue,bg=black,nobold,noitalics,nounderscore]"
    '';
  };
}
