short() {
  case "$1" in
    English*) echo EN ;;
    Russian*) echo RU ;;
    *) printf '%s' "${1:0:2}" | tr '[:lower:]' '[:upper:]' ;;
  esac
}

emit() {
  local layout
  layout=$(hyprctl devices -j 2>/dev/null | jq -r '[.keyboards[] | select(.main)][0].active_keymap // empty') || layout=""
  layout=${layout:-?}
  jq -nc --arg text "󰌌 $(short "$layout")" \
    --arg tip "layout: $layout"$'\nAlt+Caps Lock / click: switch' \
    '{text: $text, tooltip: $tip}'
}

emit

sock="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
socat -U - "UNIX-CONNECT:$sock" 2>/dev/null | while IFS= read -r line; do
  if [[ $line == activelayout'>>'* ]]; then
    # Read the main keyboard so other keyboards cannot change the indicator.
    emit
  fi
done
