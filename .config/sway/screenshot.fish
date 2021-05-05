#!/bin/fish

set DATE (date +%Y%m%d-%H%M%S)

set folder $HOME/Pictures/Screenshots

if ! test -d $folder
	mkdir -p $folder
end

if test "$argv[1]" = "-s"
	set name $folder/$DATE-s.png
	notify-send -t 2000 "Selection screenshot started" "Select a window or area to capture."
	swaymsg -t get_tree | \
		jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | \
		slurp | \
		grim -g - $name && \
		notify-send "Screenshot saved" "Your capture was saved as $name." || \
		notify-send "Selection screenshot cancelled" "Nothing was saved."
else if test "$argv[1]" = "-o"
	set name $folder/$DATE-o.png
	notify-send -t 2000 "Display screenshot started" "Select a display to capture."
	slurp -o | \
		grim -g - $name && \
		notify-send "Screenshot saved" "Your capture was saved as $name." || \
		notify-send "Selection screenshot cancelled" "Nothing was saved."
else
	set name $folder/$DATE.png
	grim $name && \
		notify-send "Full screenshot taken" "Your capture was saved as $name." || \
		notify-send "Your screenshot couldn't be saved" "Sorry about that..."
end
