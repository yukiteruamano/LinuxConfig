#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar
pkill polybar

echo "Polybar launched..."

if [ -z "$(pgrep -x polybar)" ]; then
    BAR="top"
    for m in $(polybar --list-monitors | cut -d":" -f1); do
        MONITOR=$m polybar --reload $BAR 2>&1 | tee -a /tmp/polybar.log & disown
        sleep 1
    done
else
    polybar-msg cmd restart
fi
