#!/usr/bin/env bash

if pgrep -x swaylock >/dev/null
then
    echo "swaylock is already running"
else
    paplay "$HOME/drive/Music/MuseSounds/Lock.ogg" &
fi

FORK='-f'

if [ $# -gt 0 ]; then
    if [ $1 = "--no-fork" ]; then
        echo "swaylock won't fork"
        FORK=''
    fi
fi

# get the brightness of the overall image
tmpbg='/tmp/screen.png'
/usr/bin/grim "$tmpbg"
BRIGHTNESS="$($HOME/go/bin/lockette $tmpbg)"
COLOR='ffffff'
if [ "$BRIGHTNESS" = "light" ]; then
    COLOR='000000'
fi

# /usr/bin/convert "$tmpbg" \
#     -geometry 1920x1080^ \
#     -gravity center \
#     -crop 1920x1080+0+0 \
#     -resize 5% \
#     -blur 0x1 \
#     -resize 2000% \
#     "$tmpbg"
#     # -pointsize 64 \
#     # -font "Material-Design-Icons" \
#     # -fill "#$COLOR" \
#     # -draw "gravity center text 0,0 ''"\

full="ff"
half="88"
quarter="44"
eighth="22"

fullwhite="$COLOR$full"
halfwhite="$COLOR$half"
quarterwhite="$COLOR$quarter"
eighthwhite="$COLOR$eighth"

quarterorange="ffaa00$quarter"

$HOME/go/bin/go-swaylock-multi --lock-icon $COLOR $FORK \
    -e \
    -L \
    -l \
    --ring-color=$quarterwhite \
    --ring-caps-lock-color=$quarterorange \
    --ring-wrong-color=ff0000aa \
    --ring-ver-color=$eighthwhite \
    --ring-clear-color=00000000 \
\
    --indicator-radius 64 \
    --indicator-thickness 4 \
\
    --inside-color=00000000 \
    --inside-clear-color=00000000 \
    --inside-caps-lock-color=00000000 \
    --inside-ver-color=00000000 \
    --inside-wrong-color=00000000 \
    --line-uses-inside \
\
    --key-hl-color=$fullwhite \
    --caps-lock-key-hl-color=ffaa00 \
    --caps-lock-bs-hl-color=ffaa00$quarter \
    --bs-hl-color=$quarterwhite \
    --separator-color=00000000 \
\
    --text-color=00000000 \
    --text-ver-color=00000000 \
    --text-clear-color=00000000 \
    --text-wrong-color=00000000

# \
    # --time-color=$fullwhite \
    # --date-color=$halfwhite \
    # --wrong-color=ff0000aa \
# \
    # --timestr="%-I:%M %P" \
    # --datestr="%A, %B %-d" \
# \
    # --time-align=1 \
    # --date-align=1 \
    # --verif-align=1 \
    # --wrong-align=1 \
# \
    # --indpos="256+r:h-256+r" \
    # --timepos="256:256" \
    # --datepos="tx:ty+64" \
# \
    # --time-font="Fira Sans Thin" \
    # --date-font="Fira Sans" \
    # --wrong-font="Fira Sans" \
# \
    # --timesize=128 \
    # --datesize=24 \
    # --wrongtext="" \
    # --noinputtext="" \

