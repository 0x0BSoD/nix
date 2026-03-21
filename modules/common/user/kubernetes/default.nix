{ ... }: {
  imports = [
    ./k9s
    ./kubectl.nix
    ./kubecm.nix
    ./kubectx.nix
    ./minikube.nix
    ./k3s.nix
    ./stern.nix
  ];
}
