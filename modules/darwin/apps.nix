{pkgs, ...}: {
  home.packages = with pkgs; [
    coreutils
    chatgpt
    chatgpt-cli
    pinentry_mac
    raycast
    pam-reattach
  ];
}
