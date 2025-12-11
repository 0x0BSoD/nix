{inputs, ...}: {
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };

    useGlobalPkgs = true;
    useUserPackages = true;
    overwriteBackup = true;
    backupFileExtension = "backup";

    users.alex = {inputs, ...}: {
      programs.home-manager.enable = true;
      home = {
        stateVersion = "25.11";

        sessionVariables = {
          EDITOR = "nvim";
          PAGER = "";

          GOPATH = "$HOME/Projects/go";
          GO111MODULE = "on";

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
      # Add Neovim as a user package
      imports = [
        inputs.zen-browser.homeModules.beta
        inputs.spicetify-nix.homeManagerModules.spicetify

        ../../modules/common/apps/git/git.home.nix

        ../../modules/common/apps/develop/nixdev.nix
        ../../modules/common/apps/develop/go.nix
        ../../modules/common/apps/develop/zig.nix
        ../../modules/common/apps/develop/python.nix
        ../../modules/common/apps/develop/nodejs.nix
        ../../modules/common/apps/develop/tools.nix

        ../../modules/common/apps/kubernetes/kubectl.nix

        ../../modules/common/apps/bat.nix
        ../../modules/common/apps/btop.nix
        ../../modules/common/apps/delta.nix
        ../../modules/common/apps/neovim.nix
        ../../modules/common/apps/ghostty
        ../../modules/common/shell

        ../../modules/common/apps/zed.nix
        ../../modules/common/apps/zen-browser.nix
        ../../modules/common/apps/spicetify.nix
        ../../modules/common/apps/spotify-player.nix
      ];
    };
  };
  users.users.alex = {
    name = "alex";
    home = "/Users/alex";
  };
}
