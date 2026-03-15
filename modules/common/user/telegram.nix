{pkgs, ...}: {
  home.packages = with pkgs; [
    telegram-desktop
  ];
}
# {pkgs, ...}: let
#   pinnedPkgs = import (builtins.fetchTarball {
#     url = "https://github.com/NixOS/nixpkgs/archive/6fe88b3e141c.tar.gz";
#     sha256 = "1pa1jb2r43nkkkp86dd13v1hn4ss7v5hdyfziqa4jjkjf3in33d6";
#   }) {system = pkgs.stdenv.hostPlatform.system;};
# in {
#   home.packages = [
#     pinnedPkgs.telegram-desktop
#   ];
# }

