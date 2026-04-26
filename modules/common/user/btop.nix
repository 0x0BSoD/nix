{...}: {
  programs.btop = {
    enable = true;

    settings = {
      theme_background = false;
      truecolor = true;
      force_tty = true;
      presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";

      #* Conflicting keys for h:"help" and k:"kill" is accessible while holding shift.
      vim_keys = false;

      rounded_corners = true;
      terminal_sync = true;
      graph_symbol = "braille";
      shown_boxes = "cpu mem net proc";
      update_ms = 2000;
      proc_sorting = "cpu lazy";
      proc_reversed = false;
      show_cpu_freq = true;
      freq_mode = "first";
    };
  };
}
