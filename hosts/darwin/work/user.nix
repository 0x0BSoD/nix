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
        "$HOME/.krew/bin"
        "$HOME/.local/bin"
      ];
      sessionVariables = {
        _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
      };
    };

    imports = [
      inputs.zen-browser.homeModules.beta
      inputs.spicetify-nix.homeManagerModules.spicetify

      "${appsPath}/git/git.work.nix"

      "${appsPath}/develop"
      "${appsPath}/kubernetes"

      "${appsPath}/bat.nix"
      "${appsPath}/btop.nix"
      "${appsPath}/delta.nix"
      # "${appsPath}/terraform.nix"
      "${appsPath}/vault.nix"
      "${appsPath}/redis.nix"
      "${appsPath}/goland.nix"
      # "${appsPath}/sysdig.nix"
      "${appsPath}/ghostty"
      "${appsPath}/shell"

      "${appsPath}/zed.nix"
      "${appsPath}/zen-browser.nix"
      "${appsPath}/spicetify.nix"

      "${appsPath}/session-vars.nix"
    ];
  };
}
