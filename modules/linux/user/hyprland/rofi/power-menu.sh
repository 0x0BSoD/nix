#!/usr/bin/env bash

theme="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/powermenu-theme.rasi"

menu() {
  rofi -dmenu -i -no-custom -format i -theme "$theme" -p "$1"
}

confirm() {
  local choice
  choice=$(printf 'Cancel\n%s\n' "$1" | menu "$1?") || return 1
  [[ "$choice" == 1 ]]
}

choice=$(printf '%s\n' 'Lock' 'Suspend' 'Logout' 'Reboot' 'Power Off' | menu 'Power') || exit 0

case "$choice" in
  0) exec hyprlock ;;
  # Hypridle's before_sleep_cmd locks the session before suspend.
  1) exec systemctl suspend ;;
  2)
    if confirm 'Logout'; then
      exec hyprctl dispatch exit
    fi
    ;;
  3)
    if confirm 'Reboot'; then
      exec systemctl reboot
    fi
    ;;
  4)
    if confirm 'Power Off'; then
      exec systemctl poweroff
    fi
    ;;
esac
