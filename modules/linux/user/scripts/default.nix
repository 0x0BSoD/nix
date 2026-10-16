{pkgs, lib, ...}: let
  ocr = pkgs.tesseract.override {enableLanguages = ["eng" "rus"];};
  dependencies = {
    "screenshot.sh" = with pkgs; [coreutils grim grimblast slurp swappy wl-clipboard libnotify ocr];
    "screen-record.sh" = with pkgs; [coreutils hyprland jq libnotify slurp systemd util-linux wf-recorder];
  };
  scriptDir = ./bin;
  scriptEntries = builtins.readDir scriptDir;
  shellScripts = builtins.filter (
    name: scriptEntries.${name} == "regular" && lib.hasSuffix ".sh" name
  ) (builtins.attrNames scriptEntries);
  mkScript = name:
    if builtins.hasAttr name dependencies then pkgs.writeShellApplication {
      name = lib.removeSuffix ".sh" name;
      runtimeInputs = dependencies.${name};
      text = builtins.readFile (scriptDir + "/${name}");
    } else pkgs.writeScriptBin (lib.removeSuffix ".sh" name) (
      builtins.readFile (scriptDir + "/${name}")
    );
in {
  home.packages = map mkScript shellScripts;
}
