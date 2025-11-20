{...}: {
  programs.bat = {
    enable = true;
    config = {
      pager = "never";
      theme = "Nord";
      style = "full";
      color = "always";
      italic-text = "always";
    };
    # extraPackages = with pkgs.bat-extras; [
    #   batman
    #   batpipe
    #   batgrep
    # ];
  };
}
