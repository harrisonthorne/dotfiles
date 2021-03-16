#!/bin/bash

if pgrep -x wf-recorder >/dev/null
then
    pkill --signal SIGINT wf-recorder
    exit
fi

DATE=`date +%s`

folder=$HOME/Videos/Recordings
mkdir -p $folder

notify-send -t 3000 "Video capture started" "Recording starts in 3 seconds. Use the same keyboard shortcut to stop."

sleep 3
wf-recorder -f $folder/$DATE.mp4 && notify-send "Video capture stopped" "Your video was saved in ~/Videos/Recordings." || notify-send "Video capture failed" "Nothing was saved."
