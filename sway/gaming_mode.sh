#!/bin/bash

kill_progs=("syncthing" "brave" "rot8" "redshift")

mesg="<b>Gaming mode</b>\n\nThe following programs will be terminated and Steam will start. You will need to start them again afterwards.\n\n"
for prog in $kill_progs; do
    mesg+="\t$prog\n"
done
mesg+="\nIs this okay?"

no="No"
yes="Go ahead"

answer=$(echo -e "$no\n$yes" | rofi -dmenu -p '' -mesg "$mesg")

if [ "$answer" = "$yes" ]; then
    for prog in $kill_progs; do
        killall $prog
    done

    # run steam
    steam -steamos -bigpicture
fi
