#!/bin/bash

if pgrep -x ffmpeg >/dev/null
then
    pkill --signal SIGTERM ffmpeg
    exit
fi

DATE=`date +%s`

folder=$HOME/Videos/Recordings
mkdir -p $folder

notify-send -t 3000 "Video capture started" "Recording starts in 3 seconds. Use the same keyboard shortcut to stop."

sleep 3
ffmpeg -f x11grab -video_size 1920x1080 -framerate 60 -i $DISPLAY -f pulse -i default -c:v libx264 -preset ultrafast -c:a aac $folder/$DATE.mp4

notify-send "Video capture stopped" "Your video was saved in ~/Videos/Recordings."
