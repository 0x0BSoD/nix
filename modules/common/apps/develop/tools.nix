{pkgs, ...}: {
  home.packages = with pkgs; [
    helm-ls
    shellcheck
    shfmt
    stylua
  ];
}
