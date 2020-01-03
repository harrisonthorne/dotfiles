playerctl metadata --follow | while :
do
    read line
    muse-status notify playerctl
    echo "playerctl"
done &
