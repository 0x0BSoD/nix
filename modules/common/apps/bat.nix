{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      pager = "never";
      theme = "gruvbox-dark";
      style = "full";
      color = "always";
      italic-text = "always";
    };
    extraPackages = with pkgs.bat-extras; [
      batman
      batpipe
      batgrep
    ];
  };
}
