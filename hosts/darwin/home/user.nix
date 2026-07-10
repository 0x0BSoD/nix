{
  self,
  inputs,
  primaryUser,
  ...
}: let
  appsPath = "${self}/modules/common/user";
in {
  users.users."${primaryUser}" = {
    name = primaryUser;
    home = "/Users/${primaryUser}";
  };

  home-manager.users."${primaryUser}" = {
    programs.home-manager.enable = true;

    home = {
      stateVersion = "25.11";
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
      "${appsPath}/ghostty"
      "${appsPath}/neovim.nix"
      "${appsPath}/shell"
      "${appsPath}/zed.nix"
      "${appsPath}/zen-browser.nix"
      "${appsPath}/spicetify.nix"
      "${appsPath}/session-vars.nix"
    ];
  };
}
