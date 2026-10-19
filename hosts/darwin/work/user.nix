{
  self,
  inputs,
  pkgs,
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
    programs.home-manager.enable = false;

    # Avoid the bundle-touch permission probe and its global TCC reset (home-manager#8336).
    targets.darwin.copyApps.enableChecks = false;

    home = {
      stateVersion = "25.11";
      packages = with pkgs; [
        asciiquarium
        claude-code
        docker-compose
        lfk
        pinentry_mac
      ];
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
      inputs.nixvim.homeModules.nixvim

      ./teleport.nix

      "${appsPath}/git/git.work.nix"

      "${appsPath}/develop"
      "${appsPath}/kubernetes"

      "${appsPath}/bat.nix"
      "${appsPath}/btop.nix"
      "${appsPath}/chatgpt.nix"
      "${appsPath}/delta.nix"
      "${appsPath}/ghostty"
      "${appsPath}/goland.nix"
      "${appsPath}/neovim.nix"
      "${appsPath}/obsidian.nix"
      "${appsPath}/redis.nix"
      "${appsPath}/shell"
      "${appsPath}/terraform.nix"
      "${appsPath}/vault.nix"

      "${appsPath}/zen-browser.nix"
      "${appsPath}/spicetify.nix"

      "${appsPath}/session-vars.nix"
      "${self}/modules/darwin/user/window-management.nix"
    ];
  };
}
