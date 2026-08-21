#!/bin/bash
# Kill all unattached tmux sessions
tmux list-sessions 2>/dev/null \
  | grep -v '(attached)' \
  | cut -d: -f1 \
  | xargs -I{} tmux kill-session -t {} 2>/dev/null
