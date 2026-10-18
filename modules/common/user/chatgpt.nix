{
  inputs,
  lib,
  pkgs,
  ...
}: let
  codex = inputs.codex.packages.${pkgs.stdenv.hostPlatform.system};
in {
  home.packages =
    [codex.codex-cli]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [codex.chatgpt-desktop]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [pkgs.chatgpt];
}
