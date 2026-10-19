{
  inputs,
  pkgs,
  ...
}: let
  codex = inputs.codex.packages.${pkgs.stdenv.hostPlatform.system};
in {
  home.packages = [
    codex.codex-cli
    codex.chatgpt-desktop
  ];
}
