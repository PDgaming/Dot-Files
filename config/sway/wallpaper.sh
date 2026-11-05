#!/bin/sh
# Picks the wallpaper by time of day and hands it to awww.
# Day (6AM-6PM):   Arch-Base.png
# Night (6PM-6AM): animated/peaceful_night.gif

WALLPAPER_DIR="$HOME/Programming/Dot-Files/wallpaper"
DAY_WALLPAPER="$WALLPAPER_DIR/Arch-Base.png"
NIGHT_WALLPAPER="$WALLPAPER_DIR/animated/peaceful_night.gif"

is_night() {
  hour=$(date +%H)
  [ "$hour" -ge 18 ] || [ "$hour" -lt 6 ]
}

seconds_until_next_change() {
  if is_night; then
    target=6
  else
    target=18
  fi
  now=$(date +%s)
  next=$(date -d "today $target:00" +%s)
  [ "$next" -le "$now" ] && next=$(date -d "tomorrow $target:00" +%s)
  echo $((next - now))
}

apply() {
  tries=0
  until awww img "$1"; do
    tries=$((tries + 1))
    [ "$tries" -ge 10 ] && return 1
    sleep 1
  done
}

case "$1" in
day)
  apply "$DAY_WALLPAPER"
  ;;
night)
  apply "$NIGHT_WALLPAPER"
  ;;
"" | loop)
  while :; do
    if is_night; then
      apply "$NIGHT_WALLPAPER"
    else
      apply "$DAY_WALLPAPER"
    fi
    sleep "$(seconds_until_next_change)"
  done
  ;;
*)
  echo "usage: wallpaper.sh [day|night]" >&2
  exit 2
  ;;
esac
