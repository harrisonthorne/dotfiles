if [ $1 = 1 ]; then
    notify-send "Battery charging"
else
    notify-send "Adapter unplugged"
fi
