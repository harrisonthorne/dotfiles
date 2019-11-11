#!/bin/bash

DATE=`date +%s`

folder=$HOME/Pictures/Screenshots

mkdir -p $folder
/bin/grim $folder/$DATE.png
notify-send "Screenshot taken" "Your picture was saved as $folder/$DATE.png."
