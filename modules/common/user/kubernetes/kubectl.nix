{pkgs, ...}: {
  home.packages = with pkgs; [
    kubectl
    kubecolor
    kubectl-tree
  ];
}
