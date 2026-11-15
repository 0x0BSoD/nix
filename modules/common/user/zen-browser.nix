{
  pkgs,
  lib,
  ...
}: {
  programs.zen-browser = {
    enable = true;
  };

  # Nord userChrome/userContent copied into whichever profile Zen uses on this
  # machine (profile dir names are random per machine). Existing different
  # files are backed up as *.bak-<timestamp> first.
  home.activation.zenNord = lib.hm.dag.entryAfter ["writeBoundary"] ''
    base=${
      if pkgs.stdenv.hostPlatform.isDarwin
      then ''"$HOME/Library/Application Support/Zen"''
      else ''"$HOME/.config/zen"''
    }
    rel=$(${pkgs.gawk}/bin/awk -F= '
      /^\[/ {sec=$0}
      $1=="Path" {path[sec]=$2}
      $1=="Default" && sec ~ /^\[Install/ {inst=$2}
      $1=="Default" && $2=="1" && sec ~ /^\[Profile/ {prof=sec}
      END {print (inst != "" ? inst : path[prof])}
    ' "$base/profiles.ini" 2>/dev/null)
    if [ -n "$rel" ] && [ -d "$base/$rel" ]; then
      chrome="$base/$rel/chrome"
      mkdir -p "$chrome"
      for f in userChrome.css userContent.css; do
        if [ -e "$chrome/$f" ] && ! cmp -s "$chrome/$f" ${./zen-nord}/$f; then
          cp -p "$chrome/$f" "$chrome/$f.bak-$(date +%Y%m%d-%H%M%S)"
        fi
        install -m 644 ${./zen-nord}/$f "$chrome/$f"
      done
      grep -qs legacyUserProfileCustomizations "$base/$rel/user.js" ||
        echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);' >> "$base/$rel/user.js"
    fi
  '';

  xdg.mimeApps = let
    value = let
      zen-browser = zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta;
    in
      zen-browser.meta.desktopFileName;

    associations = builtins.listToAttrs (
      map (name: {inherit name value;}) [
        "application/x-extension-shtml"
        "application/x-extension-xhtml"
        "application/x-extension-html"
        "application/x-extension-xht"
        "application/x-extension-htm"
        "x-scheme-handler/unknown"
        "x-scheme-handler/mailto"
        "x-scheme-handler/chrome"
        "x-scheme-handler/about"
        "x-scheme-handler/https"
        "x-scheme-handler/http"
        "application/xhtml+xml"
        "application/json"
        "text/html"
      ]
    );
  in {
    associations.added = associations;
    defaultApplications = associations;
  };
}
