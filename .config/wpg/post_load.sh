#!/usr/bin/env bash

killall muse-status

awesome-client "awesome.restart()" &

lockbackground="$HOME/.lock_screen.png"
cp $HOME/.config/wpg/wallpapers/$(wpg -c) $lockbackground
/usr/bin/convert "$lockbackground" \
    -resize 1920x1080^ \
    -gravity center \
    -extent 1920x1080 \
    -resize 5% \
    -fill "#000000" \
    -colorize 50% \
    -blur 10x2 \
    -resize 2000% \
    "$lockbackground" &
