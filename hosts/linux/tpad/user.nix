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
  programs.wireshark.enable = true;

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

      "${appsPath}/ansible.nix"
      "${appsPath}/develop"
      "${appsPath}/kubernetes"
      "${appsPath}/terraform.nix"

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
      "${appsPath}/wireshark.nix"

      "${linuxPath}/appearance.nix"
      "${linuxPath}/gnome.nix"
      "${linuxPath}/hunspell.nix"
      "${linuxPath}/hyprland"
      "${linuxPath}/niri"
      "${linuxPath}/nemo.nix"
      "${linuxPath}/other.nix"
      "${linuxPath}/printing.nix"
      "${linuxPath}/swaylock.nix"
      "${linuxPath}/swayosd.nix"
      "${linuxPath}/waypaper.nix"
      "${linuxPath}/wine.nix"

      "${appsPath}/session-vars.nix"
      "${linuxPath}/scripts"
    ];
  };

  users.users."${primaryUser}" = {
    isNormalUser = true;
    name = primaryUser;
    description = "Aleksandr Simonov";
    extraGroups = [
      "adbusers"
      "audio"
      "disk"
      "docker"
      "input"
      "kvm"
      "libvirtd"
      "lp"
      "networkmanager"
      "scanner"
      "video"
      "wheel"
      "wireshark"
    ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
  nix.settings.allowed-users = [primaryUser];
}
