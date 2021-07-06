#! /usr/bin/env fish

cat $HOME/.emoji_list.txt | bemenu -p Emoji $argv | rev | cut -d'(' -f2- | rev | string trim | awk '{printf $0}' | wl-copy
