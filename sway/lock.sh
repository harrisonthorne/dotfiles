#!/usr/bin/env bash

if pgrep -x swaylock >/dev/null
then
    echo "swaylock is already running"
else
    paplay "$HOME/Music/MuseSounds/Lock.ogg" &
fi

FORK='-f'

if [ $# -gt 0 ]; then
    if [ $1 = "--no-fork" ]; then
        echo "swaylock won't fork"
        FORK=''
    fi
fi

tmpbg='/tmp/screen.png'

cp $HOME/.config/wpg/wallpapers/$(wpg -c) $tmpbg
# /usr/bin/convert "$tmpbg" \
#     -gravity center \
#     -extent 1920x1080 \
#     -resize 5% \
#     -blur 1x2 \
#     -resize 2000% \
#     -fill "#0C0D11" \
#     -colorize 75% \
#     "$tmpbg"
/usr/bin/convert "$tmpbg" \
    -resize 1920x1080^ \
    -gravity center \
    -extent 1920x1080 \
    -fill "#0C0D11" \
    -colorize 75% \
    "$tmpbg"

primary="fdfdffc0"
primaryFaded="fdfdff20"
secondary="8383a920"
transparent="00000000"
orange="ffaa00"

swaylock $FORK -i "$tmpbg" \
    -e \
    --clock \
    --scaling=fill \
    -L \
    -l \
\
    --ring-color=$transparent \
    --ring-wrong-color=ff0000aa \
    --ring-ver-color=$transparent \
    --ring-caps-lock-color=$transparent \
    --ring-clear-color=$orange \
\
    --indicator \
    --indicator-radius 384 \
    --indicator-thickness 4 \
\
    --inside-color=$transparent \
    --inside-ver-color=$transparent \
    --inside-wrong-color=$transparent \
    --inside-clear-color=$transparent \
    --inside-caps-lock-color=$transparent \
\
    --key-hl-color=$primaryFaded \
    --bs-hl-color=$secondary \
    --caps-lock-key-hl-color=$orange \
    --caps-lock-bs-hl-color=$secondary \
    --separator-color=$transparent \
    -n \
\
    --text-color=$primary \
    --text-ver-color=$transparent \
    --text-clear-color=$transparent \
    --text-wrong-color=$transparent \
    --text-caps-lock-color=$orange \
\
    --font "Cantarell Thin" \
    --font-size 128 \
\
    --timestr="%-l:%M %P" \
    --datestr=""
