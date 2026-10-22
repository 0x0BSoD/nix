{pkgs, ...}: {
  imports = [
    ./k9s
    ./minikube.nix
    ./k3s.nix
  ];

  home.packages = with pkgs; [
    kubebuilder
    kubecm
    kubecolor
    kubectl
    kubectl-tree
    kubectx
    kubernetes-helm
    stern
  ];
}
