#! /bin/fish

set desc (echo '' | bemenu -p 'Timestamp description?' $argv)
$HOME/notebook/record_time.fish $desc
