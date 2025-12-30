#!/bin/bash

bluetoothctl connect 41:42:29:C1:66:09
sleep 2
pactl set-sink-volume @DEFAULT_SINK@ 40%
