{pkgs, ...}: {
  home.packages = with pkgs; [
    jetbrains.goland
  ];

  home.file.".ideavimrc".source = ./ideavimrc;
}
