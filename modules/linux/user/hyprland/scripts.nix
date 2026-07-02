{pkgs, ...}: {
  home.packages = [
    (pkgs.writeScriptBin "music" (builtins.readFile ./music.sh))
  ];
}
