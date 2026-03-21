{ ... }: {
  imports = [
    ./nixdev.nix
    ./go.nix
    ./java.nix
    ./rust.nix
    ./python.nix
    ./nodejs.nix
    ./tools.nix
  ];
}
