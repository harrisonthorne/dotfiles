#! /bin/fish

set desc (echo '' | bemenu -p 'Clock in for?' $argv)
$HOME/notebook/record_time.fish '(clock in)' $desc
