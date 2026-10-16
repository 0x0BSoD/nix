#!/usr/bin/env bash

set -euo pipefail

dir="$HOME/Pictures/Screenshots"
time=$(date +'%Y_%m_%d_at_%Hh%Mm%Ss')
file="${dir}/Screenshot_${time}.png"

copy() {
    GRIMBLAST_HIDE_CURSOR=0 grimblast --notify --freeze copy area
}

save() {
    GRIMBLAST_HIDE_CURSOR=0 grimblast --notify --freeze save area "$file"
}

swappy_() {
    GRIMBLAST_HIDE_CURSOR=0 grimblast --notify --freeze save area "$file"
    swappy -f "$file"
}

if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
fi

if [[ "${1:-}" == "--copy" ]]; then
    copy
elif [[ "${1:-}" == "--save" ]]; then
    save
elif [[ "${1:-}" == "--swappy" ]]; then
    swappy_
elif [[ "${1:-}" == "--ocr" ]]; then
    geometry=$(slurp) || exit 0
    if ! text=$(grim -g "$geometry" - | tesseract stdin stdout -l eng+rus 2>/dev/null); then
        notify-send -u critical "Screenshot OCR failed"
        exit 1
    fi
    if [[ -n ${text//[[:space:]]/} ]]; then
        printf '%s' "$text" | wl-copy
        notify-send "Text copied" "Recognized English/Russian text is in the clipboard."
    else
        notify-send "No text found" "Try selecting a clearer or larger region."
    fi
else
    echo "Available Options: --copy --save --swappy --ocr"
fi

exit 0
