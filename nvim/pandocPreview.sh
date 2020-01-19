#! /usr/bin/env bash

cmd="pandoc \"$1\" -o \"$1.pdf\" --wrap=preserve && pkill -HUP mupdf" 
echo $cmd

bash -c "$cmd"

mupdf "$1.pdf" &

echo "$1" | entr -n bash -c "$cmd"
