{pkgs, ...}: {
  security = {
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
      wheelNeedsPassword = false;
    };
    rtkit.enable = true;
    polkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };
  };
}
