{
  pkgs,
  inputs,
  ...
}: let
  appsPath = "../../../modules/common/apps";
  linuxPath = "../../../modules/linux/apps";
in {
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

      services.kanshi = {
        enable = true;
        profiles = {
          undocked = {
            outputs = [
              {
                criteria = "eDP-1";
                status = "enable";
                mode = "1920x1080@60Hz";
                scale = 1.0;
                position = "0,0";
              }
            ];
          };
          docked = {
            outputs = [
              {
                criteria = "eDP-1";
                status = "disable";
              }
              {
                criteria = "HDMI-A-1";
                status = "enable";
                mode = "2560x1080@75.00Hz";
                position = "0,0";
              }
            ];
          };
        };
      };

      home = {
        stateVersion = "25.11";
        username = "alex";
        homeDirectory = "/home/alex";
      };

      qt = {
        enable = true;
        platformTheme.name = "qtct";
        style.name = "kvantum";
      };

      imports = [
        inputs.zen-browser.homeModules.beta
        inputs.spicetify-nix.homeManagerModules.spicetify

        ## TODO: make config common for instances
        ./${appsPath}/git/git.home.nix

        ./${appsPath}/develop/nixdev.nix
        ./${appsPath}/develop/go.nix
        ./${appsPath}/develop/python.nix
        ./${appsPath}/develop/nodejs.nix
        ./${appsPath}/develop/tools.nix

        ./${appsPath}/kubernetes/kubectl.nix

        ./${appsPath}/bat.nix
        ./${appsPath}/btop.nix
        ./${appsPath}/docker.nix
        ./${appsPath}/delta.nix
        ./${appsPath}/neovim.nix
        ./${appsPath}/obsidian.nix
        ./${appsPath}/telegram.nix
        ./${appsPath}/ghostty
        ./${appsPath}/shell

        ./${appsPath}/zed.nix
        ./${appsPath}/zen-browser.nix
        ./${appsPath}/spicetify.nix

        ./${linuxPath}/hyprland
        ./${linuxPath}/waypaper.nix
        ./${linuxPath}/gtk.nix
        ./${linuxPath}/qt.nix
        ./${linuxPath}/gnome.nix
        ./${linuxPath}/swaylock.nix
        ./${linuxPath}/swayosd.nix
        ./${linuxPath}/nemo.nix
        ./${linuxPath}/other.nix

        ../../../modules/common/session-vars.nix
        ../../../modules/linux/scripts
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
