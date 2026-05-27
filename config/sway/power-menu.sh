#!/bin/bash
OPTIONS="lock\nsuspend"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Power:")

case "$CHOICE" in
lock)
  exec swaylock -c 000000
  ;;
suspend)
  systemctl suspend
  ;;
esac
