{pkgs, inputs, ...}: let
  codex = inputs.codex.packages.${pkgs.stdenv.hostPlatform.system};
in {
  home.packages = with codex; [
    codex-cli
    chatgpt-desktop
  ];
}
