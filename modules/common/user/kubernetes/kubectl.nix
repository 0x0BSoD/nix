{pkgs, ...}: {
  home.packages = with pkgs; [
    kubectl
    kubecolor
  ];
}
