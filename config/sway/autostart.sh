#!/bin/bash

manage_process() {
  local dir=$1
  local cmd=$2
  local name=$3

  echo "Managing $name..."

  # 1. Kill existing instances
  # We use [m]ain.py trick so grep doesn't find itself
  pids=$(pgrep -f "$name")
  if [ -n "$pids" ]; then
    kill $pids
    sleep 1
    # Check if still running and force kill if necessary
    kill -9 $(pgrep -f "$name") 2>/dev/null
  fi

  # 2. Start the process
  cd "$dir" || {
    notify-send -u critical "Error" "Directory not found for $name"
    return 1
  }
  # Execute directly using the venv's python binary
  if $cmd & then
    notify-send -t 2000 "Success" "$name launched successfully."
  else
    notify-send -u critical "Launch Failed" "Could not start $name."
  fi
}

# --- Start Discord Bot ---
# Note: Instead of sourcing, we call the venv python directly
manage_process \
  "/mnt/Programming/programming/Github/Perverted-Old-Man-Discord-Bot/" \
  "./venv/bin/python3 main.py" \
  "main.py"

# --- Start Heartbeat (Bun/TS) ---
manage_process \
  "/mnt/Programming/programming/Github/United-Blocks" \
  "bun run heartbeat.ts" \
  "heartbeat.ts"

