{inputs, ...}: let
  appsPath = "../../../modules/common/apps";
in {
  users.users."aleksandr.simonov" = {
    name = "aleksandr.simonov";
    home = "/Users/aleksandr.simonov";
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };

    useGlobalPkgs = true;
    useUserPackages = true;
    overwriteBackup = true;
    backupFileExtension = "backup";

    users."aleksandr.simonov" = {
      programs.home-manager.enable = true;
      home = {
        stateVersion = "25.11";

        sessionPath = [
          "$HOME/.krew/bin"
        ];

        sessionVariables = {
          EDITOR = "nvim";
          PAGER = "";

          GOPATH = "$HOME/Projects/go";
          GO111MODULE = "on";

          _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";

          FZF_CTRL_R_OPTS = "
            --preview 'echo {}' --preview-window up:3:hidden:wrap
            --bind 'ctrl-/:toggle-preview'
            --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
            --color header:italic
            --header 'Press CTRL-Y to copy command into clipboard'";
          FZF_CTRL_T_OPTS = "
            --walker-skip .git,node_modules,target
            --preview 'bat -n --color=always {}'
            --bind 'ctrl-/:change-preview-window(down|hidden|)'";
          FZF_ALT_C_OPTS = "
            --walker-skip .git,node_modules,target
            --preview 'tree -C {}'";
        };
      };

      imports = [
        inputs.zen-browser.homeModules.beta
        inputs.spicetify-nix.homeManagerModules.spicetify

        ./${appsPath}/git/git.work.nix

        ./${appsPath}/develop/nixdev.nix
        ./${appsPath}/develop/go.nix
        ./${appsPath}/develop/java.nix
        ./${appsPath}/develop/python.nix
        ./${appsPath}/develop/nodejs.nix
        ./${appsPath}/develop/tools.nix

        ./${appsPath}/kubernetes/k9s
        ./${appsPath}/kubernetes/kubectl.nix
        ./${appsPath}/kubernetes/kubecm.nix
        ./${appsPath}/kubernetes/kubectx.nix
        ./${appsPath}/kubernetes/stern.nix

        ./${appsPath}/bat.nix
        ./${appsPath}/btop.nix
        ./${appsPath}/delta.nix
        ./${appsPath}/neovim.nix
        ./${appsPath}/terrafrom.nix
        ./${appsPath}/vault.nix
        ./${appsPath}/redis.nix
        ./${appsPath}/ghostty
        ./${appsPath}/common/shell

        ./${appsPath}/zed.nix
        ./${appsPath}/zen-browser.nix
        ./${appsPath}/spicetify.nix
        ./${appsPath}/spotify-player.nix
      ];
    };
  };
}
