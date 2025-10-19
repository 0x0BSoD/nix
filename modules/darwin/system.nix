{
  self,
  primaryUser,
  lib,
  ...
}: let
  suUser = cmd: ''
    /usr/bin/sudo -u ${primaryUser} /bin/sh -lc ${lib.escapeShellArg cmd}
  '';
in {
  system = {
    primaryUser = primaryUser;
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 6;
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        NSTableViewDefaultSizeMode = 1;
      };

      finder = {
        FXPreferredViewStyle = "Nlsv";
        FXDefaultSearchScope = "SCcf";
        FXRemoveOldTrashItems = true;
        ShowStatusBar = true;
        ShowPathbar = true;
        # SidebarDevicesSectionDisclosedState = true;
        # SidebarPlacesSectionDisclosedState = true;
        # SidebarShowingiCloudDesktop = false;
      };

      screencapture.location = "~/Pictures/screenshots";

      dock = {
        autohide = true;
        mru-spaces = false;
      };
    };

    activationScripts.fixFinder = lib.mkAfter ''
      ${suUser ''defaults delete com.apple.finder FXInfoPanesExpanded || true''}
      ${suUser ''defaults delete com.apple.finder FXDesktopVolumePositions || true''}

      ${suUser ''
        defaults write com.apple.finder FK_StandardViewSettings -dict-add ListViewSettings '
        { "columns" = (
            { "ascending" = 1; "identifier" = "name";         "visible" = 1; "width" = 300; },
            { "ascending" = 0; "identifier" = "dateModified"; "visible" = 1; "width" = 181; },
            { "ascending" = 0; "identifier" = "size";         "visible" = 1; "width" = 97;  }
          );
          "iconSize" = 16;
          "showIconPreview" = 0;
          "sortColumn" = "name";
          "textSize" = 12;
          "useRelativeDates" = 1;
        }'
      ''}

      ${suUser ''
        defaults write com.apple.finder FK_StandardViewSettings -dict-add ExtendedListViewSettings '
        { "columns" = (
            { "ascending" = 1; "identifier" = "name";         "visible" = 1; "width" = 300; },
            { "ascending" = 0; "identifier" = "dateModified"; "visible" = 1; "width" = 181; },
            { "ascending" = 0; "identifier" = "size";         "visible" = 1; "width" = 97;  }
          );
          "iconSize" = 16;
          "showIconPreview" = 0;
          "sortColumn" = "name";
          "textSize" = 12;
          "useRelativeDates" = 1;
        }'
      ''}

      /usr/bin/find ~${primaryUser} -name ".DS_Store" -type f -delete 2>/dev/null || true
      uid="$(/usr/bin/id -u ${primaryUser})"
      /bin/launchctl asuser "$uid" /usr/bin/killall Finder 2>/dev/null || true
    '';
  };
}
