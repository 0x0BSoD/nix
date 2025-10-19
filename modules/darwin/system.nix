{
  self,
  primaryUser,
  ...
}: {
  system = {
    primaryUser = primaryUser;
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 6;
    defaults = {
      screencapture.location = "~/Pictures/screenshots";

      dock = {
        autohide = true;
        mru-spaces = false;
      };

      # The domain consisting of defaults meant to be seen by all applications.
      NSGlobalDomain = {
        # Set the sidebar icon size to small
        NSTableViewDefaultSizeMode = 1;
        # Show all filename extensions
        AppleShowAllExtensions = true;
      };

      # Finder
      finder = {
        # Set the default Finder view to list view
        FXPreferredViewStyle = "Nlsv";
        # Sets default search scope to the current folder
        FXDefaultSearchScope = "SCcf";
      };
    };
  };
}
