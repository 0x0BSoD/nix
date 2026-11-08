{...}: {
  wayland.windowManager.hyprland = {
    settings.config.binds.movefocus_cycles_fullscreen = true;

    extraConfig = ''
      do
        local mod = "SUPER"
        local function exec(keys, command, rules)
          hl.bind(keys, hl.dsp.exec_cmd(command, rules))
        end

        exec(mod .. " + F1", "show-keybinds")
        exec(mod .. " + Return", "ghostty --gtk-single-instance=true")
        exec("ALT + Return", "ghostty", { float = true, size = "1111 700" })
        exec(mod .. " + SHIFT + Return", "ghostty", { fullscreen = true })
        exec(mod .. " + B", "zen-beta", { workspace = "1 silent" })
        hl.bind(mod .. " + Q", hl.dsp.window.close())
        hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
        hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
        exec(mod .. " + Space", "toggle-float")
        exec(mod .. " + D", "rofi -show drun")
        exec("ALT + Escape", "hyprlock")
        exec(mod .. " + SHIFT + Escape", "power-menu")
        hl.bind(mod .. " + P", hl.dsp.window.pseudo())
        hl.bind(mod .. " + X", hl.dsp.layout("togglesplit"))
        exec(mod .. " + T", "toggle-opacity")
        exec(mod .. " + E", "nemo")
        exec("ALT + E", "nemo", { float = true, size = "1111 700" })
        exec(mod .. " + SHIFT + B", "toggle-waybar")
        exec(mod .. " + C", "hyprpicker -a")
        exec(mod .. " + SHIFT + W", "waypaper", { float = true, size = "925 615" })
        exec(mod .. " + N", "swaync-client -t -sw")
        exec("CTRL + SHIFT + Escape", "missioncenter", { workspace = "9" })

        exec("Print", "screenshot --copy")
        exec(mod .. " + Print", "screenshot --save")
        exec(mod .. " + SHIFT + Print", "screenshot --swappy")
        exec(mod .. " + CTRL + Print", "screenshot --ocr")
        -- Press again to stop; Shift selects the focused monitor.
        exec(mod .. " + ALT + R", "screen-record toggle area")
        exec(mod .. " + ALT + SHIFT + R", "screen-record toggle screen")

        for _, direction in ipairs({
          { "left", "h", -80, 0 },
          { "down", "j", 0, 80 },
          { "up", "k", 0, -80 },
          { "right", "l", 80, 0 },
        }) do
          for _, key in ipairs({ direction[1], direction[2] }) do
            hl.bind(mod .. " + " .. key, function()
              hl.dispatch(hl.dsp.focus({ direction = direction[1] }))
              hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
            end)
            hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = direction[1] }))
            hl.bind(mod .. " + CTRL + " .. key, hl.dsp.window.resize({
              x = direction[3], y = direction[4], relative = true,
            }))
            hl.bind(mod .. " + ALT + " .. key, hl.dsp.window.move({
              x = direction[3], y = direction[4], relative = true,
            }))
          end
        end
        hl.bind("CTRL + ALT + up", hl.dsp.focus({ window = "floating" }))
        hl.bind("CTRL + ALT + down", hl.dsp.focus({ window = "tiled" }))

        for workspace = 1, 10 do
          local key = workspace % 10
          hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
          hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace, follow = false }))
        end
        hl.bind(mod .. " + CTRL + C", hl.dsp.window.move({ workspace = "empty" }))
        hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
        hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
        hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
        hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

        exec("XF86AudioPlay", "playerctl play-pause")
        exec("XF86AudioNext", "playerctl next")
        exec("XF86AudioPrev", "playerctl previous")
        exec("XF86AudioStop", "playerctl stop")
        exec(mod .. " + V", "cliphist list | rofi -dmenu -p clipboard | cliphist decode | wl-copy")
      end
    '';
  };
}
