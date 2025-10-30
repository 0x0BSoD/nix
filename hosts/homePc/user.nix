{
  pkgs,
  inputs,
  ...
}: {
  programs.dconf.enable = true;
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };

    useGlobalPkgs = true;
    useUserPackages = true;
    overwriteBackup = true;
    backupFileExtension = "backup";

    users.alex = {
      programs.home-manager.enable = true;
      home = {
        stateVersion = "25.11";
        username = "alex";

        homeDirectory = "/home/alex";

        sessionVariables = {
          EDITOR = "vim";
          PAGER = "";

          GOPATH = "$HOME/Projects/go";
          GO111MODULE = "on";

          NIXOS_OZONE_WL = 1;
          WLR_NO_HARDWARE_CURSORS = 1;

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

        ## TODO: make config common for instances
        ../../modules/common/apps/git/git.homeMac.nix

        ../../modules/common/apps/alacritty.nix
        ../../modules/common/apps/bat.nix
        ../../modules/common/apps/btop.nix
        ../../modules/common/apps/delta.nix
        ../../modules/common/apps/fzf.nix
        ../../modules/common/shell

        ../../modules/common/apps/zed.nix
        ../../modules/common/apps/zen-browser.nix
        ../../modules/common/apps/spicetify.nix
        ../../modules/common/apps/other.nix

        ../../modules/linux/apps/hyprland
        ../../modules/linux/apps/waypaper.nix
        ../../modules/linux/apps/other.nix

        ../../modules/linux/scripts
      ];
    };
  };

  users.users.alex = {
    isNormalUser = true;
    name = "alex";
    description = "Aleksandr Simonov";

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
  nix.settings.allowed-users = ["alex"];
}
