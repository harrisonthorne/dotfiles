#! /bin/sh

PANEL_WM_NAME=lemon

if xdo id -a "$PANEL_WM_NAME" > /dev/null ; then
	printf "%s\n" "The panel is already running." >&2
	exit 1
fi

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

for o in `xrandr | grep " connected" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/"`; do
    muse-status -p fffcff -s cbbe92 | lemonbar -n "$PANEL_WM_NAME" -B "#e5341f0d" -g x32 -f "Roboto:pixelsize=13" -f "MaterialDesignIcons:pixelsize=17" $o | sh &
done

sleep 3s

for id in `xdo id -a $PANEL_WM_NAME`; do
    echo "applying for $id"
    xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" "$id"
done

wait
