{ lib, osConfig, ... }: let
  palette = import ../catppuccin-mocha-palette.nix;
in lib.mkIf osConfig.programs.niri.enable {
  xdg.configFile."waybar-niri/style.css".text = ''
    ${palette}

    window#waybar {
      transition-property: background-color;
      transition-duration: 0.5s;
      background: #2E3440;
      border-radius: 0px;
    }

    window#waybar.hidden {
      opacity: 0.2;
    }

    #waybar.empty #window {
      background: none;
    }

    .modules-left,
    .modules-center,
    .modules-right {
      background: #2E3440;
      border: 0px solid @overlay0;
      padding-top: 0px;
      padding-bottom: 0px;
      padding-right: 0px;
      padding-left: 0px;
      border-radius: 0px;
    }

    .modules-left,
    .modules-right {
      border: 0px solid @blue;
      padding-top: 1px;
      padding-bottom: 1px;
      padding-right: 4px;
      padding-left: 4px;
    }

    #battery,
    #clock,
    #cpu,
    #memory,
    #network,
    #pulseaudio,
    #tray,
    #window,
    #workspaces,
    #custom-notification,
    #custom-separator {
      padding-top: 3px;
      padding-bottom: 3px;
      padding-right: 6px;
      padding-left: 6px;
    }

    #battery {
      color: @green;
    }

    @keyframes blink {
      to { color: @surface0; }
    }

    #battery.critical:not(.charging) {
      background-color: @red;
      color: @text;
      animation-name: blink;
      animation-duration: 0.5s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
    }

    #clock {
      color: @text;
    }

    #cpu {
      color: @green;
    }

    #memory {
      color: @sky;
    }

    #network {
      color: @teal;
    }

    #network.disconnected,
    #network.disabled {
      background-color: @surface0;
      color: @text;
    }

    #pulseaudio {
      color: @green;
    }

    #pulseaudio.muted {
      color: @red;
    }

    #tray > .passive {
      -gtk-icon-effect: dim;
    }

    #tray > .needs-attention {
      -gtk-icon-effect: highlight;
    }

    #window {
      color: @mauve;
    }

    #workspaces button {
      box-shadow: none;
      text-shadow: none;
      padding: 0px;
      border-radius: 9px;
      padding-left: 4px;
      padding-right: 4px;
      transition: all 0.5s cubic-bezier(0.55, -0.68, 0.48, 1.682);
    }

    #workspaces button:hover {
      border-radius: 10px;
      color: @overlay0;
      background-color: @surface0;
      padding-left: 2px;
      padding-right: 2px;
      transition: all 0.3s cubic-bezier(0.55, -0.68, 0.48, 1.682);
    }

    #workspaces button.active {
      color: @teal;
      border-radius: 10px;
      padding-left: 8px;
      padding-right: 8px;
      transition: all 0.3s cubic-bezier(0.55, -0.68, 0.48, 1.682);
    }

    #workspaces button.urgent {
      color: @red;
      border-radius: 0px;
    }
  '';
}
