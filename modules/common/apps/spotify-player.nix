{...}: {
  programs.spotify-player = {
    enable = true;
    settings = {
      client_id_command = "echo $SPOTIFY_ID";
      theme = "nord";
      playback_window_position = "Top";
      copy_command = {
        command = "wl-copy";
        args = [];
      };
      device = {
        audio_cache = false;
        normalization = false;
      };
    };
    themes = [
      {
        name = "nord";
        palette = {
          # base
          black = "#2E3440"; # nord0
          red = "#BF616A"; # nord11
          green = "#A3BE8C"; # nord14
          yellow = "#EBCB8B"; # nord13
          blue = "#81A1C1"; # nord9
          magenta = "#B48EAD"; # nord15
          cyan = "#88C0D0"; # nord8
          white = "#E5E9F0"; # nord5

          # bright / accent
          bright_black = "#4C566A"; # nord3
          bright_red = "#BF616A"; # nord11 (same, keeps warnings sharp)
          bright_green = "#A3BE8C"; # nord14
          bright_yellow = "#EBCB8B"; # nord13
          bright_blue = "#5E81AC"; # nord10
          bright_magenta = "#B48EAD"; # nord15
          bright_cyan = "#8FBCBB"; # nord7
          bright_white = "#ECEFF4"; # nord6
        };

        component_style = {
          # Titles / borders
          block_title = {
            fg = "Cyan";
            modifiers = ["Bold"];
          };
          border = {fg = "BrightBlack";};

          # Playback area
          playback_track = {
            fg = "White";
            modifiers = ["Bold"];
          };
          playback_artists = {
            fg = "Cyan";
            modifiers = ["Bold"];
          };
          playback_album = {
            fg = "BrightCyan";
          };
          playback_metadata = {
            fg = "BrightBlack";
          };
          playback_progress_bar = {
            bg = "Black";
            fg = "Green";
          };

          current_playing = {
            fg = "Green";
            modifiers = ["Bold"];
          };

          # Page / lists
          page_desc = {
            fg = "Cyan";
            modifiers = ["Bold"];
          };
          table_header = {
            fg = "BrightBlue";
            modifiers = ["Bold"];
          };

          selection = {
            fg = "Black";
            bg = "BrightCyan";
            modifiers = ["Bold" "Reversed"];
          };
        };
      }
    ];
  };
}
