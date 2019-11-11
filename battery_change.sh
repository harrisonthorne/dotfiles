#!/bin/bash

eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME ck-launch-sess)/environ)";

battery_level=`/usr/bin/acpi -b | /bin/grep -P -o '[0-9]+(?=%)'`
if [ $battery_level -le 15 ]
then
    /usr/bin/notify-send -u critical "Your device's battery is critically low" "Charge your device or suspend it to avoid losing unsaved work." &
	/usr/bin/aplay "/home/harrisonthorne/drive/Music/MuseSounds/CriticalBattery.wav"
elif [ $battery_level -le 30 ]
then
    /usr/bin/notify-send "Your device's battery is getting low" "Just a warning. You might want to charge your device." &
	/usr/bin/aplay "/home/harrisonthorne/drive/Music/MuseSounds/LowBattery.wav"
fi
# /usr/bin/notify-send "Battery check script was run"
