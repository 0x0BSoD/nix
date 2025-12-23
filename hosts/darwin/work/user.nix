{inputs, ...}: let
  appsPath = "../../../modules/common/apps";
in {
  users.users."aleksandr.simonov" = {
    name = "aleksandr.simonov";
    home = "/Users/aleksandr.simonov";
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };

    useGlobalPkgs = true;
    useUserPackages = true;
    overwriteBackup = true;
    backupFileExtension = "backup";

    users."aleksandr.simonov" = {
      programs.home-manager.enable = true;
      home = {
        stateVersion = "25.11";

        sessionPath = [
          "$HOME/.krew/bin"
        ];

        stateVariables._JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";

        imports = [
          inputs.zen-browser.homeModules.beta
          inputs.spicetify-nix.homeManagerModules.spicetify

          ./${appsPath}/git/git.work.nix

          ./${appsPath}/develop/nixdev.nix
          ./${appsPath}/develop/go.nix
          ./${appsPath}/develop/java.nix
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
          ./${appsPath}/delta.nix
          ./${appsPath}/neovim.nix
          ./${appsPath}/terrafrom.nix
          ./${appsPath}/vault.nix
          ./${appsPath}/redis.nix
          ./${appsPath}/ghostty
          ./${appsPath}/shell

          ./${appsPath}/zed.nix
          ./${appsPath}/zen-browser.nix
          ./${appsPath}/spicetify.nix
          ./${appsPath}/spotify-player.nix

          ../../../modules/common/session-vars.nix
        ];
      };
    };
  };
}
