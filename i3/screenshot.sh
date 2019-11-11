#!/bin/bash

DATE=`date +%s`

folder=$HOME/Pictures/Screenshots
if [ ! -f $folder ]; then
	mkdir -p $folder
fi

if [ $1 = "-s" ]; then
	name=$folder/$DATE-selected.png
	notify-send "Selection screenshot started" "Select a window or area to capture."
	/usr/bin/maim -s -u $name && notify-send "Screenshot saved" "Your capture was saved as $name." || notify-send "Selection screenshot cancelled" "Nothing was saved."
else
	name=$folder/$DATE.png
	/usr/bin/maim $name && notify-send "Screenshot taken" "Your picture was saved as $name." || notify-send "Your screenshot couldn't be saved" "Sorry about that..."
fi
