#!/bin/bash
OPTIONS="lock\nsuspend\nlogout\nreboot\nshutdown"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Power:")

case "$CHOICE" in
lock)
  exec swaylock -c 000000
  ;;
suspend)
  systemctl suspend
  ;;
logout)
  swaymsg exit
  ;;
reboot)
  reboot
  ;;
shutdown)
  shutdown now
  ;;
esac
