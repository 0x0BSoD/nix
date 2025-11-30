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
      loginwindow = {
        GuestEnabled = false;
        SHOWFULLNAME = false;
        # Disables the ability for a user to access the console by typing “>console” for a username at the login window.
        DisableConsoleAccess = true;
      };

      NSGlobalDomain = {
        NSAutomaticWindowAnimationsEnabled = false;
        AppleFontSmoothing = 2;
        AppleShowAllExtensions = true;
        NSTableViewDefaultSizeMode = 1;
        AppleInterfaceStyle = "Dark";
        AppleInterfaceStyleSwitchesAutomatically = false;
        "com.apple.sound.beep.feedback" = 1;
        "com.apple.sound.beep.volume" = 0.606531; # 50%
        "com.apple.mouse.tapBehavior" = 1; # tap to click
        "com.apple.swipescrolldirection" = true; # "natural" scrolling
        "com.apple.keyboard.fnState" = true;
        "com.apple.springing.enabled" = false;
        "com.apple.trackpad.scaling" = 3.0; # fast
        "com.apple.trackpad.enableSecondaryClick" = true;
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 14;
        KeyRepeat = 1;
        AppleShowScrollBars = "Automatic";
        NSScrollAnimationEnabled = true;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSWindowResizeTime = 0.001;
        # when the below is on, it means you can hold cmd+ctrl and click anywhere on a window to drag it around
        NSWindowShouldDragOnGesture = true;
        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;
      };

      finder = {
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        QuitMenuItem = true;
        _FXShowPosixPathInTitle = true;
        FXPreferredViewStyle = "Nlsv";
        FXDefaultSearchScope = "SCcf";
        FXRemoveOldTrashItems = true;
        ShowStatusBar = true;
        ShowPathbar = true;
      };

      trackpad = {
        # silent clicking = 0, default = 1
        ActuationStrength = 0;
        # enable tap to click
        Clicking = false;
        Dragging = false; # tap and a half to drag
        # three finger click and drag
        TrackpadThreeFingerDrag = false;
      };

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.2;
        expose-animation-duration = 0.2;
        tilesize = 48;
        launchanim = false;
        static-only = false;
        showhidden = true;
        show-recents = false;
        show-process-indicators = true;
        orientation = "bottom";
        mru-spaces = false;
        expose-group-apps = true;
      };

      CustomUserPreferences = {
        NSGlobalDomain = {
          WebKitDeveloperExtras = true;
          AppleMiniaturizeOnDoubleClick = false;
          NSAutomaticTextCompletionEnabled = true;
          _HIHideMenuBar = 0;
          "com.apple.sound.beep.flash" = false;
        };
        "com.apple.finder" = {
          OpenWindowForNewRemovableDisk = true;
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = true;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
          FXInfoPanesExpanded = {
            General = true;
            OpenWith = true;
            Privileges = true;
          };
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.screensaver" = {
          # Require password immediately after sleep or screen saver begins
          askForPassword = 1;
          askForPasswordDelay = 0;
        };
        "com.apple.screencapture" = {
          location = "~/Desktop";
          type = "png";
        };
        "com.apple.ActivityMonitor" = {
          OpenMainWindow = true;
          IconType = 5; # visualize cpu in dock icon
          ShowCategory = 0; # show all processes
          SortColumn = "CPUUsage";
          SortDirection = 0;
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        "com.apple.print.PrintingPrefs" = {
          # Automatically quit printer app once the print jobs complete
          "Quit When Finished" = true;
        };
        "com.apple.SoftwareUpdate" = {
          AutomaticCheckEnabled = true;
          # Check for software updates daily, not just once per week
          # Except it doesn't seem to be doing this. And in some guides, it shows referencing a prefs file
          # Going to cover my bases and add this a second time in a second place directly in the activation script
          ScheduleFrequency = 1;
          # Download newly available updates in background
          AutomaticDownload = 1;
          # Install System data files & security updates
          CriticalUpdateInstall = 1;
        };
        "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
        # Prevent Photos from opening automatically when devices are plugged in
        "com.apple.ImageCapture".disableHotPlug = true;
        # Turn on app auto-update
        "com.apple.commerce".AutoUpdate = true;
        "com.raycast.macos" = {
          NSNavLastRootDirectory = "~/src/scripts/raycast";
          "NSStatusItem Visible raycastIcon" = 0;
          commandsPreferencesExpandedItemIds = [
            "extension_noteplan-3__00cda425-a991-4e4e-8031-e5973b8b24f6"
            "builtin_package_navigation"
            "builtin_package_scriptCommands"
            "builtin_package_floatingNotes"
          ];
          initialSpotlightHotkey = "Command-49";
          navigationCommandStyleIdentifierKey = "legacy";
          "onboarding_canShowActionPanelHint" = 0;
          "onboarding_canShowBackNavigationHint" = 0;
          "onboarding_completedTaskIdentifiers" = [
            "startWalkthrough"
            "calendar"
            "setHotkeyAndAlias"
            "snippets"
            "quicklinks"
            "installFirstExtension"
            "floatingNotes"
            "windowManagement"
            "calculator"
            "raycastShortcuts"
            "openActionPanel"
          ];
          organizationsPreferencesTabVisited = 1;
          popToRootTimeout = 60;
          raycastAPIOptions = 8;
          raycastGlobalHotkey = "Command-49";
          raycastPreferredWindowMode = "default";
          raycastShouldFollowSystemAppearance = 1;
          # presentation modes: 1=screen with active window, 2=primary screen
          raycastWindowPresentationMode = 2;
          showGettingStartedLink = 0;
          "store_termsAccepted" = 1;
          suggestedPreferredGoogleBrowser = 1;
        };
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
