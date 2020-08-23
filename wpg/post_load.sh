#!/usr/bin/env bash

killall muse-status
killall muse-status-dae

awesome-client "awesome.restart()"

tmpbg='$HOME/.lock_screen.png'

cp $HOME/.config/wpg/wallpapers/$(wpg -c) $tmpbg
/usr/bin/convert "$tmpbg" \
    -resize 1920x1080^ \
    -gravity center \
    -extent 1920x1080 \
    -fill "#0A090A" \
    -colorize 75% \
    "$tmpbg"

