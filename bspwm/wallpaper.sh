#!/bin/bash
WALL=$HOME/.config/wpg/wallpapers/$(wpg -c)
feh --bg-fill $WALL $WALL $WALL
