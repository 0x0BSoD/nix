{...}: {
  programs.kanshi = {
    enable = true;
    profiles = [
      {
        name = "mobile";
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "1920x1080@60Hz";
            scale = 1.0;
            position = "0,0";
          }
        ];
      }
      {
        name = "docked";
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "DP-1";
            status = "enable";
            mode = "preferred";
            position = "0,0";
          }
          {
            criteria = "HDMI-A-1";
            status = "enable";
            mode = "preferred";
            position = "0,0";
          }
        ];
      }
    ];
  };
}
