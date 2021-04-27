#!/usr/bin/env bash
wpg -mn

if [ "$1" = "--reload-i3" ]; then
    i3-msg restart
fi

currentWallpaper="$(wpg -c)"
fullWallpaperPath=$HOME/.config/wpg/wallpapers/$currentWallpaper

feh --bg-fill $fullWallpaperPath
echo $fullWallpaperPath

cat ~/.config/wpg/sequences # apply wpgtk's colors

killall dunst; dunst &

/usr/bin/convert "$fullWallpaperPath" \
    -geometry 1920x1080^ \
    -gravity center \
    -crop 1920x1080+0+0 \
    -resize 5% \
    -blur 0x2 \
    -resize 2000% \
    "$HOME/.config/rofi/bg.png" &
