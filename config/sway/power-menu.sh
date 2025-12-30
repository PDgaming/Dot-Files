#!/bin/bash
OPTIONS="lock\nsuspend\nreboot\nshutdown"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Power:")

case "$CHOICE" in
lock)
  exec swaylock -c 000000
  ;;
suspend)
  systemctl suspend
  ;;
reboot)
  reboot
  ;;
shutdown)
  shutdown
  ;;
esac
