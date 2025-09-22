#!/bin/bash

maim -s | tee "$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%I-%M-%S).png" | xclip -selection clipboard -t image/png
