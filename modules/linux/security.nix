{pkgs, ...}: {
  security = {
    pam.services.hyprlock.text = "auth include login";
    sudo.wheelNeedsPassword = false;
    rtkit.enable = true;
    polkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };
  };
}
