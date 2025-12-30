#!/bin/bash

FILENAME="$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
grim -g "$(slurp)" "$FILENAME"
if [ -f "$FILENAME" ]; then
  cat "$FILENAME" | wl-copy -t image/png
fi
