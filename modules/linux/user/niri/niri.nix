{ config, ... }: {
  xdg.configFile."niri/config.kdl".text = ''
    input {
        keyboard {
            xkb {
                layout "us,ru"
                options "grp:alt_caps_toggle"
            }
            repeat-delay 300
            repeat-rate 30
            numlock
        }
        touchpad {
            tap
            natural-scroll
        }
    }

    layout {
        gaps 8
        center-focused-column "never"

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }

        default-column-width { proportion 0.5; }

        focus-ring {
            width 2
            active-color "#8aadf4"
            inactive-color "#24273a"
        }

        border {
            off
        }
    }

    prefer-no-csd

    screenshot-path "~/Pictures/Screenshots/Screenshot_%Y_%m_%d_at_%Hh%Mm%Ss.png"

    animations {
        slowdown 0.8
    }

    spawn-at-startup "dbus-update-activation-environment" "--all" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP"
    spawn-at-startup "nm-applet"
    spawn-at-startup "poweralertd"
    spawn-at-startup "swaync"
    spawn-at-startup "waybar" "--config" "${config.xdg.configHome}/waybar-niri/config"
    spawn-at-startup "udiskie" "--automount" "--notify" "--smart-tray"
    spawn-at-startup "waypaper" "--restore"
    spawn-at-startup "wl-clip-persist" "--clipboard" "both"
    spawn-at-startup "wl-paste" "--watch" "cliphist" "store"

    binds {
        // Applications
        Mod+Return { spawn "ghostty" "--gtk-single-instance=true"; }
        Mod+Shift+Return { spawn "ghostty"; }
        Mod+D { spawn "rofi" "-show" "drun"; }
        Mod+E { spawn "nemo"; }
        Mod+B { spawn "zen-beta"; }
        Mod+N { spawn "swaync-client" "-t" "-sw"; }
        Mod+V { spawn "vicinae" "vicinae://extensions/vicinae/clipboard/history"; }
        Ctrl+Shift+Escape { spawn "missioncenter"; }

        // Window management
        Mod+Q { close-window; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        Mod+Space { toggle-column-is-full-width; }
        Mod+R { switch-preset-column-width; }
        Mod+Comma  { consume-window-into-column; }
        Mod+Period { expel-window-from-column; }

        // Focus
        Mod+H     { focus-column-left; }
        Mod+L     { focus-column-right; }
        Mod+J     { focus-window-down; }
        Mod+K     { focus-window-up; }
        Mod+Left  { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+Down  { focus-window-down; }
        Mod+Up    { focus-window-up; }

        // Move windows
        Mod+Shift+H     { move-column-left; }
        Mod+Shift+L     { move-column-right; }
        Mod+Shift+J     { move-window-down; }
        Mod+Shift+K     { move-window-up; }
        Mod+Shift+Left  { move-column-left; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+Down  { move-window-down; }
        Mod+Shift+Up    { move-window-up; }

        // Resize
        Mod+Ctrl+H { set-column-width "-5%"; }
        Mod+Ctrl+L { set-column-width "+5%"; }
        Mod+Ctrl+J { set-window-height "+5%"; }
        Mod+Ctrl+K { set-window-height "-5%"; }
        Mod+Ctrl+Left  { set-column-width "-5%"; }
        Mod+Ctrl+Right { set-column-width "+5%"; }
        Mod+Ctrl+Down  { set-window-height "+5%"; }
        Mod+Ctrl+Up    { set-window-height "-5%"; }

        // Workspaces
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }

        Mod+Shift+1 { move-window-to-workspace 1; }
        Mod+Shift+2 { move-window-to-workspace 2; }
        Mod+Shift+3 { move-window-to-workspace 3; }
        Mod+Shift+4 { move-window-to-workspace 4; }
        Mod+Shift+5 { move-window-to-workspace 5; }
        Mod+Shift+6 { move-window-to-workspace 6; }
        Mod+Shift+7 { move-window-to-workspace 7; }
        Mod+Shift+8 { move-window-to-workspace 8; }
        Mod+Shift+9 { move-window-to-workspace 9; }

        // Screenshots (reuse shared screenshot script)
        Print           { spawn "screenshot" "--copy"; }
        Mod+Print       { spawn "screenshot" "--save"; }
        Mod+Shift+Print { spawn "screenshot" "--swappy"; }

        // Lock / Power
        Alt+Escape       { spawn "hyprlock"; }
        Mod+Shift+Escape { spawn "power-menu"; }

        // Media
        XF86AudioPlay { spawn "playerctl" "play-pause"; }
        XF86AudioNext { spawn "playerctl" "next"; }
        XF86AudioPrev { spawn "playerctl" "previous"; }
        XF86AudioStop { spawn "playerctl" "stop"; }

        // Volume
        XF86AudioRaiseVolume allow-when-locked=true { spawn "swayosd-client" "--output-volume" "raise"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn "swayosd-client" "--output-volume" "lower"; }
        XF86AudioMute        allow-when-locked=true { spawn "swayosd-client" "--output-volume" "mute-toggle"; }

        // Brightness
        XF86MonBrightnessUp   { spawn "swayosd-client" "--brightness" "raise"; }
        XF86MonBrightnessDown { spawn "swayosd-client" "--brightness" "lower"; }
    }
  '';
}
