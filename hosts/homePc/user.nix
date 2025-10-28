{
  pkgs,
  inputs,
  ...
}: {
  users.users.alex = {
    name = "alex";
    home = "/Users/alex";

    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "networkmanager"
      "video"
      "audio"
      "libvirtd"
      "kvm"
      "docker"
      "disk"
      "adbusers"
      "lp"
      "scanner"
    ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };

  home-manager = {
    users.alex = {
      programs.home-manager.enable = true;
      xdg.enable = true;
      home = {
        stateVersion = "25.11";

        sessionVariables = {
          EDITOR = "vim";
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
      imports = [
        inputs.zen-browser.homeModules.beta
        inputs.spicetify-nix.homeManagerModules.spicetify

        ../../modules/common/apps/other.nix
        ../../modules/common/shell
        ../../modules/common/apps/alacritty.nix
        ../../modules/common/apps/bat.nix
        ../../modules/common/apps/btop.nix
        ../../modules/common/apps/delta.nix
        ../../modules/common/apps/fzf.nix
        ../../modules/common/apps/zed.nix
        ../../modules/common/apps/zen-browser.nix
        ../../modules/common/apps/spicetify.nix
        ../../modules/linux/hyprland
        ## TODO: make config common for instances
        ../../modules/common/apps/git/git.homeMac.nix
      ];
    };
  };
}
