#!/usr/bin/env bash

$(killall waybl &)

if [ "$1" = "--reload-sway" ]; then
    swaymsg reload
fi

currentWallpaper="$(wpg -c)"
fullWallpaperPath=$HOME/.config/wpg/wallpapers/$currentWallpaper

waybl "eDP-1:$fullWallpaperPath" "DP-1:$fullWallpaperPath" > waybl.log &

cat ~/.config/wpg/sequences # apply wpgtk's colors

makoctl reload &

/usr/bin/convert "$fullWallpaperPath" \
    -geometry 1920x1080^ \
    -gravity center \
    -crop 1920x1080+0+0 \
    -resize 5% \
    -blur 0x2 \
    -resize 2000% \
    "$HOME/.config/rofi/bg.png" &
