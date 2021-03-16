#!/bin/sh
bspc subscribe monitor | while read -r line; do
	case $line in
		monitor_add*|monitor_geometry*)
			if [ "$(bspc query -M | wc -l)" -eq "3" ]; then
				bspc monitor $(bspc query -M | sed -n 1p) -d 1 2 3 4
				bspc monitor $(bspc query -M | sed -n 2p) -d 5 6 7
				bspc monitor $(bspc query -M | sed -n 3p) -d 8 9 10
			elif [ "$(bspc query -M | wc -l)" -eq "2" ]; then
				bspc monitor $(bspc query -M | sed -n 1p) -d 1 2 3 4 5
				bspc monitor $(bspc query -M | sed -n 2p) -d 6 7 8 9 10
			else
				bspc monitor -d 1 2 3 4 5 6 7 8 9 10
			fi
			;;
		*)
			;;
	esac
done &
