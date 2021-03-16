#!/usr/bin/env bash

if pgrep -x gammastep >/dev/null
then
    pkill gammastep
    notify-send -u low -t 5000 "Night Display is now off" "Turn Night Display on before bed to help you sleep better."
else
    gammastep &
    notify-send -u low -t 5000 "Night Display is now on" "Night Display filters blue light to help you sleep when it's late."
fi
