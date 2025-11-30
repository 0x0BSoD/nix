{pkgs, ...}: {
  home.packages = with pkgs; [
    helm-ls
    ruff
    shellcheck
    shfmt
  ];
}
