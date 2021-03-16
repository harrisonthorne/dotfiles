#!/bin/bash

kill_progs=(syncthing firefox rot8 redshift)

mesg="<b>Gaming mode</b>

The following programs will be terminated and Steam will start. You will need to start them again afterwards.

"

for prog in "${kill_progs[@]}"; do
    mesg+=$'\t'$prog$'\n'
done
mesg+=$'\n'Is this okay?

no="No"
yes="Go ahead"

answer=$(echo -e "$no\n$yes" | rofi -dmenu -i -p '' -mesg "$mesg")

if [ "$answer" = "$yes" ]; then
    for prog in "${kill_progs[@]}"; do
        killall $prog
    done

    notify-send "Steam is starting" "Just a moment..."

    # run steam
    steam -bigpicture -steamos
fi
