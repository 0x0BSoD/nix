{
  self,
  pkgs,
  inputs,
  primaryUser,
  ...
}: let
  appsPath = "${self}/modules/common/user";
  linuxPath = "${self}/modules/linux/user";
in {
  programs.dconf.enable = true;

  home-manager.users."${primaryUser}" = {
    programs.home-manager.enable = true;

    tools.develop.java.enable = false;
    tools.kubernetes.minikube.enable = false;
    tools.kubernetes.k3s.enable = false;

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
      sessionVariables = {
        ANTHROPIC_BASE_URL = "http://10.1.1.16:8080";
      };
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

      "${appsPath}/git/git.home.nix"

      "${appsPath}/develop"
      "${appsPath}/kubernetes"

      "${appsPath}/bat.nix"
      "${appsPath}/btop.nix"
      "${appsPath}/docker.nix"
      "${appsPath}/delta.nix"
      "${appsPath}/neovim.nix"
      "${appsPath}/obsidian.nix"
      "${appsPath}/telegram.nix"
      "${appsPath}/ghostty"
      "${appsPath}/shell"

      "${appsPath}/zed.nix"
      "${appsPath}/goland.nix"
      "${appsPath}/zen-browser.nix"
      "${appsPath}/spicetify.nix"

      "${linuxPath}/appearance.nix"
      "${linuxPath}/gnome.nix"
      "${linuxPath}/hyprland"
      "${linuxPath}/nemo.nix"
      "${linuxPath}/other.nix"
      "${linuxPath}/hunspell.nix"
      "${linuxPath}/swaylock.nix"
      "${linuxPath}/swayosd.nix"
      "${linuxPath}/waypaper.nix"

      "${appsPath}/session-vars.nix"
      "${linuxPath}/scripts"
    ];
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
