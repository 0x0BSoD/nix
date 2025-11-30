{...}: {
  launchDaemons.ulimitMaxFiles = {
    enable = true;
    target = "limit.maxfiles"; # suffix .plist
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
                "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>limit.maxfiles</string>
          <key>ProgramArguments</key>
          <array>
            <string>launchctl</string>
            <string>limit</string>
            <string>maxfiles</string>
            <string>524288</string>
            <string>524288</string>
          </array>
          <key>RunAtLoad</key>
          <true/>
          <key>ServiceIPC</key>
          <false/>
        </dict>
      </plist
    '';
  };

  nix = {
    enable = false;
    settings.experimental-features = "nix-command flakes";
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
  };
}
