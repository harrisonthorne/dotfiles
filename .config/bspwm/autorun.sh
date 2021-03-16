#!/bin/bash

autostart="redshift
	dunst
	sxhkd
	kitty
	compton"

for prog in $autostart; do
	if ! pgrep -x $prog >/dev/null; then
		$prog &
	fi
done &

if ! pgrep -x polkitd >/dev/null; then
	/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
fi &

if ! pgrep -x syncthing >/dev/null; then
	syncthing -no-browser &
fi &

if ! pgrep -x pulseaudio >/dev/null; then
	pulseaudio --start &
fi &
