#! /usr/bin/env bash

cmd="pandoc \"$1\" -o \"$1.pdf\" && pkill -HUP mupdf" 
echo $cmd

bash -c "$cmd"

echo "$1" | entr -n bash -c "$cmd" &

mupdf "$1.pdf" &
