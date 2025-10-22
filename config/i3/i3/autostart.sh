#!/bin/bash

PROJECT_DIR="/mnt/Programming/programming/Github/Perverted-Old-Man-Discord-Bot"
PROGRAM_NAME="main.py"

stop_bot() {
  echo "Stopping $PROGRAM_NAME..."
  pids=$(pgrep -f "$PROGRAM_NAME")

  if [ -n "$pids" ]; then
    kill $pids

    sleep 5

    if pgrep -f "$PROGRAM_NAME" >/dev/null; then
      echo "Forcefully stopping $PROGRAM_NAME..."
      kill -9 $pids
    fi
    echo "$PROGRAM_NAME stopped."
  else
    echo "No running instance of $PROGRAM_NAME found."
  fi
}

start_bot() {
  echo "Starting $PROGRAM_NAME..."
  cd "$PROJECT_DIR"

  source venv/bin/activate

  python3 "$PROGRAM_NAME" &

  deactivate

  echo "$PROGRAM_NAME started."
}

if pgrep -f "$PROGRAM_NAME" >/dev/null; then
  stop_bot

  start_bot
else
  start_bot
fi
