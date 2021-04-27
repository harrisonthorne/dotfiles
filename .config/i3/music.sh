#!/bin/bash
status=`exec playerctl status 2>/dev/null`
if	[ "$status" = "Playing" ]; then
    title=`exec playerctl metadata title`
    artist=`exec playerctl metadata artist`
    ( echo " $title  %{F#80ffffff}$artist%{F-}" )

elif [ "$status" = "Paused" ]; then
    title=`exec playerctl metadata title`
    artist=`exec playerctl metadata artist`
    ( echo " $title  %{F#80ffffff}$artist%{F-}" )
else
    echo ""
fi
