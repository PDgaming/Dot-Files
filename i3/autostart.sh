#!/bin/bash

# Ensure D-Bus session is started (redundant if using a good display manager or .xinitrc, but safe)
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval `dbus-launch --sh-syntax --exit-with-session`
fi

# Start KWallet Daemon if not already running
if ! pgrep -x kwalletd5 > /dev/null; then
    /usr/bin/kwalletd5 & # Use & to run in background
fi

# Give it a moment to start up
sleep 2

# You might also want to ensure the authentication prompt appears if needed
# (This usually happens automatically when an app requests access)
