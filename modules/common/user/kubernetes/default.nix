{pkgs, ...}: {
  imports = [
    ./k9s
    ./minikube.nix
    ./k3s.nix
  ];

  home.packages = with pkgs; [
    kubectl
    kubecolor
    kubectl-tree
    kubecm
    kubectx
    stern
  ];
}
