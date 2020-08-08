#!/usr/bin/env bash

function run {
    echo "$1"
    if ! pgrep -f $1 ;
    then
        "$@" & disown
    fi
}

run rot8 -d eDP -i "ELAN0732:00 04F3:2537"
run light -I
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run redshift
run syncthing --no-browser
xset s 270 30
run xss-lock -n "$HOME/.config/i3/lock.sh --warn" -- $HOME/.config/i3/lock.sh -n
run picom --experimental-backends
xrdb -load ~/.Xresources
xrdb -load ~/.cache/wal/colors.Xresources
