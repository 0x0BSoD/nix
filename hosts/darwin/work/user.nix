{inputs, primaryUser, ...}: let
  appsPath = "../../../modules/common/user";
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
      sessionVariables._JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
    };

    imports = [
      inputs.zen-browser.homeModules.beta
      inputs.spicetify-nix.homeManagerModules.spicetify

      ./${appsPath}/git/git.work.nix

      ./${appsPath}/develop/nixdev.nix
      ./${appsPath}/develop/go.nix
      ./${appsPath}/develop/java.nix
      ./${appsPath}/develop/rust.nix
      ./${appsPath}/develop/python.nix
      ./${appsPath}/develop/nodejs.nix
      ./${appsPath}/develop/tools.nix

      ./${appsPath}/kubernetes/k9s
      ./${appsPath}/kubernetes/kubectl.nix
      ./${appsPath}/kubernetes/kubecm.nix
      ./${appsPath}/kubernetes/kubectx.nix
      ./${appsPath}/kubernetes/minikube.nix
      ./${appsPath}/kubernetes/k3s.nix
      ./${appsPath}/kubernetes/stern.nix

      ./${appsPath}/bat.nix
      ./${appsPath}/btop.nix
      ./${appsPath}/delta.nix
      # ./${appsPath}/terraform.nix
      ./${appsPath}/vault.nix
      ./${appsPath}/redis.nix
      ./${appsPath}/sysdig.nix
      ./${appsPath}/ghostty
      ./${appsPath}/shell

      ./${appsPath}/zed.nix
      ./${appsPath}/zen-browser.nix
      ./${appsPath}/spicetify.nix

      ../../../modules/common/user/session-vars.nix
    ];
  };
}
