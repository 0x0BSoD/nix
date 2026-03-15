#!/usr/bin/env bash
# audio-switch.sh — Waybar custom module for cycling audio sinks
# Works with PipeWire (via pactl compatibility layer) and PulseAudio

# Icon map: add more sink name fragments → icons as needed
declare -A ICONS=(
  ["hdmi"]="󰡁"
  ["speaker"]="󰓃"
  ["headphone"]="󰋋"
  ["headset"]="󰋎"
  ["usb"]="󰓃"
  ["bluetooth"]="󰂯"
  ["analog"]="󰓃"
  ["digital"]="󰕾"
)

get_icon() {
  local name="${1,,}"
  for key in "${!ICONS[@]}"; do
    [[ "$name" == *"$key"* ]] && echo "${ICONS[$key]}" && return
  done
  echo "󰕾"
}

get_sinks() {
  pactl list short sinks | awk '{print $2}'
}

get_default_sink() {
  pactl get-default-sink
}

get_sink_description() {
  local sink="$1"
  pactl list sinks | awk -v target="$sink" '
    /^Sink #/ { found=0 }
    /Name: / && $2 == target { found=1 }
    found && /Description:/ {
      sub(/.*Description: /, "")
      print
      exit
    }
  '
}

cycle_sink() {
  mapfile -t sinks < <(get_sinks)
  local current
  current=$(get_default_sink)
  local count=${#sinks[@]}
  local next_idx=0

  for i in "${!sinks[@]}"; do
    if [[ "${sinks[$i]}" == "$current" ]]; then
      next_idx=$(( (i + 1) % count ))
      break
    fi
  done

  local next_sink="${sinks[$next_idx]}"
  pactl set-default-sink "$next_sink"

  # Move all active streams to new sink
  pactl list short sink-inputs | awk '{print $1}' | while read -r stream; do
    pactl move-sink-input "$stream" "$next_sink"
  done
}

output_status() {
  local current
  current=$(get_default_sink)
  local desc
  desc=$(get_sink_description "$current")
  local icon
  icon=$(get_icon "$current $desc")

  # Shorten description for display
  local short_desc
  short_desc=$(echo "$desc" | sed 's/Built-in Audio //' | cut -c1-28)
  [[ "${#desc}" -gt 28 ]] && short_desc="${short_desc}…"

  # Waybar JSON output
  printf '{"text": "%s %s", "tooltip": "%s", "class": "audio-sink"}\n' \
    "$icon" "$short_desc" "$desc"
}

case "${1:-status}" in
  cycle)  cycle_sink ;;
  status) output_status ;;
  *)      output_status ;;
esac