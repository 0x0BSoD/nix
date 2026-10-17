{...}: {
  services.kanshi = {
    enable = true;

    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
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
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            position = "2560,0";
          }
          {
            criteria = "DP-1";
            status = "enable";
            mode = "2560x1440@60.00Hz";
            position = "0,0";
          }
        ];
      }
    ];
  };
}
