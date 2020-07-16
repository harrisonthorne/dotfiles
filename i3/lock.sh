#!/usr/bin/env bash

FORK=''

# parse args
while (( "$#" )); do
    case "$1" in
        -w|--warn)
            notify-send -u low -t 29500 -- 'Are you still there?' 'Your system will lock itself soon.'
            paplay $HOME/Music/MuseSounds/stereo/LockWarning.oga
            exit
            ;;
        -n|--no-fork)
            echo "i3lock won't fork"
            FORK='-n'
            shift
            ;;
    esac
done

paplay "$HOME/Drive/Music/MuseSounds/stereo/Lock.oga"

# suspend notifications
# pkill -u "$USER" -USR1 dunst

tmpbg='/tmp/screen.png'

cp $HOME/.config/wpg/wallpapers/$(wpg -c) $tmpbg
/usr/bin/convert "$tmpbg" \
    -resize 1920x1080^ \
    -gravity center \
    -extent 1920x1080 \
    -fill "#10180a" \
    -colorize 75% \
    "$tmpbg"

primary="f2fdffff"
secondary="6a9bcbe5"

/usr/bin/i3lock $FORK -t -i "$tmpbg" \
    -e \
    --clock \
    --ringcolor=00000000 \
    --ringwrongcolor=ff0000aa \
    --ringvercolor=$secondary \
\
    --radius 32 \
    --ring-width 4 \
\
    --insidecolor=00000000 \
    --insidevercolor=00000000 \
    --insidewrongcolor=00000000 \
\
    --keyhlcolor=$primary \
    --bshlcolor=$secondary \
    --separatorcolor=00000000 \
    --linecolor=00000000 \
\
    --timecolor=$primary \
    --datecolor=$secondary \
    --verifcolor=$secondary \
    --wrongcolor=ff0000aa \
\
    --timestr="%-I:%M %P" \
    --datestr="%A, %B %-d" \
\
    --time-align=1 \
    --date-align=1 \
    --verif-align=1 \
    --wrong-align=1 \
\
    --indpos="256+r:h-256+r" \
    --timepos="256:256" \
    --datepos="tx:ty+64" \
\
    --time-font="Cantarell Thin" \
    --date-font="Cantarell" \
    --verif-font="Cantarell" \
    --wrong-font="Cantarell" \
\
    --timesize=128 \
    --datesize=24 \
    --verifsize=16 \
    --wrongsize=16 \
\
    --veriftext="" \
    --wrongtext="" \
    --noinputtext="" \

# resume notifications
# pkill -u "$USER" -USR2 dunst

