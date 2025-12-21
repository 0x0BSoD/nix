{pkgs, ...}: {
  security = {
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (action.id == "net.reactivated.fprint.device.enroll" ||
              action.id == "net.reactivated.fprint.device.verify") {
            return polkit.Result.YES;
          }
        });
      '';
    };

    pam.services = {
      swaylock = {};
      sudo.fprintAuth = true;
      hyprlock = {
        fprintAuth = true;
        text = "auth include login";
      };
      login.fprintAuth = true;
    };
    sudo = {
      enable = true;
      # wheelNeedsPassword = false;
    };
    rtkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };
  };
}
