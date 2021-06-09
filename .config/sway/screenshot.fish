#!/bin/fish

#####################
## screenshot.fish ##
#####################
## takes screenshots with sway. requires notify-send.sh for nice notifications

# format the current time for the screenshot file
set date (date +%Y%m%d-%H%M%S)

# make screnshot folder, if needed
set folder $HOME/Pictures/Screenshots
if ! test -d $folder
	mkdir -p $folder
end

# sets the location of the notification file to replace notifications
set notif_file $XDG_RUNTIME_DIR/screenshot.notif

if test "$argv[1]" = "-s"
	set name $folder/$date-s.png

    # get initial notification id, so we can dismiss it right before we capture
	set nid (notify-send.sh -p -R $notif_file "Selection screenshot started" "Select a window or area to capture.")

    # get region to capture
	set region (swaymsg -t get_tree | \
		jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | \
		slurp)

    # get status to see if selection was cancelled
    set slurp_status $status
    if test $slurp_status -ne 0
		notify-send.sh -R $notif_file "Screenshot cancelled" "No problem!"
        exit $slurp_status
    end

    # close notification before capturing
    notify-send.sh -s $nid

    # snap!
    grim -g $region $name && \
		notify-send.sh -R $notif_file "Screenshot saved" "Your capture was saved as $name." || \
		notify-send.sh -R $notif_file "Screenshot failed" "There was an error, so nothing was saved. Sorry. :("

else if test "$argv[1]" = "-o"
	set name $folder/$date-o.png
    # get initial notification id, so we can dismiss it right before we capture
	set nid (notify-send.sh -p -R $notif_file "Display screenshot started" "Select a display to capture.")

    # get region to capture
	set region (slurp -o)

    # get status to see if selection was cancelled
    set slurp_status $status
    if test $slurp_status -ne 0
		notify-send.sh -R $notif_file "Screenshot cancelled" "No problem!"
        exit $slurp_status
    end

    # close notification before capturing
    notify-send.sh -s $nid

    # snap!
    grim -g $region $name && \
		notify-send.sh -R $notif_file "Screenshot saved" "Your capture was saved as $name." || \
		notify-send.sh -R $notif_file "Screenshot failed" "There was an error, so nothing was saved. Sorry. :("
else
	set name $folder/$date.png
	grim $name && \
		notify-send.sh -R $notif_file "Full screenshot taken" "Your capture was saved as $name." || \
		notify-send.sh -R $notif_file "Screenshot failed" "There was an error, so nothing was saved. Sorry. :("
end
