#!/usr/bin/env bash
# Region screenshot -> satty annotator
set -euo pipefail

dir="$HOME/Pictures/Screen"
mkdir -p "$dir"

region="$(slurp)" || exit 0   # cancelled with ESC -> exit quietly

grim -c -g "$region" - | satty --filename - \
    --output-filename "$dir/$(date +%F_%H-%M-%S)_hyprshot.png" \
    --actions-on-enter save-to-clipboard,save-to-file,exit
