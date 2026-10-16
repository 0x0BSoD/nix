#!/usr/bin/env bash

set -euo pipefail

unit=screen-record.service
run="${XDG_RUNTIME_DIR:?XDG_RUNTIME_DIR is required}"
state="$run/screen-record.json"

recording() {
    systemctl --user is-active --quiet "$unit"
}

say() {
    notify-send -a "Screen recording" "$1" "${2:-}"
}

stop() {
    recording || return 0
    # systemd sends SIGINT and waits for the encoder to finish the video.
    systemctl --user stop "$unit"
    local output
    output=$(jq -r '.output' "$state")
    rm -f "$state"
    if [[ -s $output ]]; then
        say "Recording saved" "$output"
    else
        say "Recording stopped" "No video was written; check journalctl --user -u $unit."
    fi
}

start() {
    local mode=${1:-area} geometry output
    local args=()
    case "$mode" in
        area)
            geometry=$(slurp) || return 0
            args+=(-g "$geometry")
            ;;
        screen)
            output=$(hyprctl monitors -j | jq -er '.[] | select(.focused) | .name')
            args+=(-o "$output")
            ;;
        *) echo "Expected area or screen" >&2; return 2 ;;
    esac
    if [[ ${2:-} == --audio ]]; then
        args+=(--audio)
    elif [[ -n ${2:-} ]]; then
        echo "Expected --audio" >&2
        return 2
    fi
    mkdir -p "$HOME/Videos/Recordings"
    output="$HOME/Videos/Recordings/Recording_$(date +%Y-%m-%d_%H-%M-%S_%N).mp4"
    jq -nc --arg output "$output" --argjson started "$(date +%s)" \
        '{output: $output, started: $started}' >"$state"
    if ! systemd-run --user --quiet --collect --unit="$unit" --service-type=exec \
        --property=KillSignal=SIGINT --property=TimeoutStopSec=30 \
        --property=PartOf=hyprland-session.target \
        --setenv="WAYLAND_DISPLAY=${WAYLAND_DISPLAY:?}" --setenv="XDG_RUNTIME_DIR=$run" \
        -- "$(command -v wf-recorder)" "${args[@]}" -f "$output"; then
        rm -f "$state"
        say "Recording failed to start" "Check journalctl --user -u $unit."
        return 1
    fi
    say "Recording started" "Super+Alt+R or click REC in Waybar to stop."
}

bar() {
    if recording && [[ -f $state ]]; then
        local elapsed text output
        elapsed=$(( $(date +%s) - $(jq -r '.started' "$state") ))
        (( elapsed >= 0 )) || elapsed=0
        printf -v text '󰑋 REC %02d:%02d' "$((elapsed / 60))" "$((elapsed % 60))"
        output=$(jq -r '.output' "$state")
        jq -nc --arg text "$text" --arg tip "$output"$'\nClick to stop recording' \
            '{text: $text, tooltip: $tip, class: "recording"}'
    else
        echo '{"text":"","class":"idle"}'
    fi
}

case ${1:-toggle} in
    bar) bar ;;
    status) if recording; then echo on; else echo off; fi ;;
    toggle|stop)
        # Serialize controls, including region selection, to prevent duplicate recordings.
        exec 9>"$run/screen-record.lock"
        flock -n 9 || exit 0
        if [[ ${1:-toggle} == stop ]] || recording; then
            stop
        else
            start "${2:-area}" "${3:-}"
        fi
        ;;
    *) echo "Usage: screen-record [toggle [area|screen] [--audio]|stop|status|bar]" >&2; exit 2 ;;
esac
