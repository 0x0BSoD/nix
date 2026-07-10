{
  self,
  pkgs,
  inputs,
  primaryUser,
  ...
}: let
  appsPath = "${self}/modules/common/user";
  linuxPath = "${self}/modules/linux/user";
  hostPath = "${self}/hosts/linux/tpad";
in {
  programs.wireshark.enable = true;

  home-manager.users."${primaryUser}" = {
    programs.home-manager.enable = true;

    tools.develop.java.enable = false;
    tools.kubernetes.minikube.enable = false;
    tools.kubernetes.k3s.enable = false;

    home = {
      stateVersion = "25.11";
      username = primaryUser;
      homeDirectory = "/home/${primaryUser}";
      sessionPath = [
        "$HOME/go/bin"
        "$HOME/.local/bin"
      ];
    };

    imports = [
      inputs.zen-browser.homeModules.beta
      inputs.spicetify-nix.homeManagerModules.spicetify
      inputs.nixvim.homeModules.nixvim
      inputs.noctalia.homeModules.default

      "${hostPath}/kanshi.nix"

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

      "${appsPath}/goland.nix"
      "${appsPath}/zen-browser.nix"
      "${appsPath}/spicetify.nix"
      "${appsPath}/wireshark.nix"

      "${linuxPath}/appearance.nix"
      "${linuxPath}/gnome.nix"
      "${linuxPath}/hunspell.nix"
      "${linuxPath}/hyprland"
      "${linuxPath}/nemo.nix"
      "${linuxPath}/other.nix"
      "${linuxPath}/swaylock.nix"
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
