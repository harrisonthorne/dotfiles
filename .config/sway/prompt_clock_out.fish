#! /bin/fish

set desc (echo '' | bemenu -p 'Clock out for?' $argv)
$HOME/notebook/record_time.fish '(clock out)' $desc
