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
  home-manager.users."${primaryUser}" = {
    programs.home-manager.enable = true;

    home = {
      stateVersion = "26.05";
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

      "${appsPath}/git/git.home.nix"

      "${appsPath}/develop"
      "${appsPath}/kubernetes"

      "${appsPath}/bat.nix"
      "${appsPath}/btop.nix"
      "${appsPath}/delta.nix"
      "${appsPath}/neovim.nix"
      "${appsPath}/obsidian.nix"
      "${appsPath}/telegram.nix"
      "${appsPath}/ghostty"
      "${appsPath}/shell"

      "${appsPath}/goland.nix"
      "${appsPath}/zen-browser.nix"
      "${appsPath}/spicetify.nix"

      "${linuxPath}/appearance.nix"
      "${linuxPath}/codex.nix"
      "${linuxPath}/other.nix"

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
