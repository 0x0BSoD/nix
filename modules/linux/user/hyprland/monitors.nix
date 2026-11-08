{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    settings.monitor = {
      output = "";
      mode = "preferred";
      position = "auto";
      scale = 1;
      bitdepth = 8;
    };

    extraConfig = ''
      -- nwg-displays writes Lua overrides. require() tracks them for reloads.
      do
        local directory = (os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")) .. "/hypr"
        package.path = directory .. "/?.lua;" .. package.path
        for _, name in ipairs({ "monitors", "workspaces" }) do
          local file = io.open(directory .. "/" .. name .. ".lua", "r")
          if file then
            file:close()
            require(name)
          end
        end
      end
    '';
  };

  home.packages = with pkgs; [nwg-displays];
}
