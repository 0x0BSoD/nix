{pkgs, ...}: {
  home.packages = with pkgs; [
    avahi
    cups
    cups-filters
    nssmdns
  ];
}
