#!/usr/bin/env bash

if pgrep -x redshift > /dev/null
then
    killall redshift
    notify-send -u low -t 5000 "Redshift is now off" "Turn Redshift on before bed to help you sleep better."
else
    redshift &
    notify-send -u low -t 5000 "Redshift is now on" "Redshift filters blue light to help you sleep when it's late."
fi
