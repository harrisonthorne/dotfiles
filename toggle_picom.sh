#!/usr/bin/env bash

if pgrep -x picom >/dev/null
then
    pkill picom
    notify-send -u low -t 5000 "Gaming mode is on" "Compositing has been turned off for better performance."
else
    picom &
    notify-send -u low -t 5000 "Gaming mode is off" "Compositing has been enabled."
fi
