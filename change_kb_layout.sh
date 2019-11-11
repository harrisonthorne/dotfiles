#! /bin/bash

notify_error() {
    notify-send "Couldn't switch keyboard layouts" "An error occurred."
}

notify_success() {
    notify-send "Keyboard layout changed" "You're now using the $1 layout."
}

change_layout() {
    case $1 in
        "QWERTY")
            setxkbmap us && notify_success $1 || notify_error
            ;;
        "Colemak")
            setxkbmap us -variant colemak && notify_success $1 || notify_error
            ;;
        *)
            notify_error
            ;;
    esac
}

if [[ -z "$@" ]]; then
    # list options
    echo -e "QWERTY\nColemak"
else
    # change layout
    change_layout $@
fi
