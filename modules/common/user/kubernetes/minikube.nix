{
  lib,
  pkgs,
  config,
  ...
}: {
  options.tools.kubernetes.minikube.enable = lib.mkEnableOption "minikube" // {default = true;};

  config = lib.mkIf config.tools.kubernetes.minikube.enable {
    home.packages = [pkgs.minikube];
  };
}
