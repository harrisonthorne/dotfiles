# vim ft=bash

# PID=$(pgrep muse-status)

# if [ ! -z "$PID" ]; then
#     pkill -o muse-status &2> /dev/null
# fi

# muse-status -S "779855" | lemonbar -d -a 2 -H -B "#C00f1a10" -g x32 -o -8 -f "Fira Sans:size=10" -o -9 -f "Material Design Icons:size=12" &

killall mako
mako &
