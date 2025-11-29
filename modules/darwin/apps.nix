{pkgs, ...}: {
  home.packages = with pkgs; [
    chatgpt
    chatgpt-cli
    pinentry_mac
    raycast
  ];
}
