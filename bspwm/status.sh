#!/bin/bash

# i3status | while :
# do
# 	read line
# 	bspwm=`bspc wm --get-status`
# 	# xwindow=`xdotool getwindowfocus getwindowname`
# 	song=`playerctl metadata title`
# 	artist=`playerctl metadata artist`
# 	echo "%{l}$bspwm%{c}$line%{r}$song - $artist"
# done

bspc subscribe report | while :
do
    read line
    muse-status notify bspwm
    muse-status notify window
    echo "bspwm"
done &

playerctl metadata --follow | while :
do
    read line
    muse-status notify playerctl
    echo "playerctl"
done &
