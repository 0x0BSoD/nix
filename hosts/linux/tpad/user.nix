{
  pkgs,
  inputs,
  primaryUser,
  ...
}: let
  appsPath = "../../../modules/common/user";
  linuxPath = "../../../modules/linux/user";
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

    users."${primaryUser}" = {
      programs.home-manager.enable = true;

      services.kanshi = {
        enable = true;

        settings = [
          {
            profile.name = "undocked";
            profile.outputs = [
              {
                criteria = "eDP-1";
                status = "enable";
                mode = "1920x1080@60Hz";
                scale = 1.0;
                position = "0,0";
              }
            ];
          }

          {
            profile.name = "docked";
            profile.outputs = [
              {
                criteria = "eDP-1";
                status = "disable";
              }
              {
                criteria = "HDMI-A-1";
                status = "enable";
                mode = "2560x1080@180.00Hz";
                position = "0,0";
              }
            ];
          }
        ];
      };

      home = {
        stateVersion = "25.11";
        username = primaryUser;
        homeDirectory = "/home/${primaryUser}";
        sessionPath = [
          "$HOME/go/bin"
          "$HOME/.local/bin"
        ];
      };

      xdg = {
        enable = true;
        desktopEntries = {
          nemo = {
            name = "Nemo";
            genericName = "File manager";
            exec = "nemo %U";
            icon = "nemo";
            terminal = false;
            categories = ["System" "FileManager"];
          };
        };
      };

      imports = [
        inputs.zen-browser.homeModules.beta
        inputs.spicetify-nix.homeManagerModules.spicetify
        inputs.nixvim.homeModules.nixvim

        ## TODO: make config common for instances
        ./${appsPath}/git/git.home.nix

        ./${appsPath}/develop/nixdev.nix
        ./${appsPath}/develop/go.nix
        ./${appsPath}/develop/rust.nix
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
        ./${appsPath}/docker.nix
        ./${appsPath}/delta.nix
        ./${appsPath}/neovim.nix
        ./${appsPath}/obsidian.nix
        ./${appsPath}/telegram.nix
        ./${appsPath}/ghostty
        ./${appsPath}/shell

        ./${appsPath}/zed.nix
        ./${appsPath}/goland.nix
        ./${appsPath}/zen-browser.nix
        ./${appsPath}/spicetify.nix

        ./${linuxPath}/appearance.nix
        ./${linuxPath}/gnome.nix
        ./${linuxPath}/hyprland
        ./${linuxPath}/nemo.nix
        ./${linuxPath}/other.nix
        ./${linuxPath}/swaylock.nix
        ./${linuxPath}/swayosd.nix
        ./${linuxPath}/waypaper.nix

        ../../../modules/common/user/session-vars.nix
        ../../../modules/linux/user/scripts
      ];
    };
  };

  users.users."${primaryUser}" = {
    isNormalUser = true;
    name = primaryUser;
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
  nix.settings.allowed-users = [primaryUser];
}
