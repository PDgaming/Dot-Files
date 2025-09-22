#!/bin/bash

sleep 5

systemctl --user restart bluetooth.service || sudo systemctl restart bluetooth.service

bluetoothctl power on

bluetoothctl connect 6D:31:6A:FD:A9:7D
