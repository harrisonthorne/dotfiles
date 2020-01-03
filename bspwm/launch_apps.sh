$HOME/.config/wpg/wp_init.sh

light -I &
nohup alacritty &
nohup dunst &
nohup sxhkd -m -1 &
nohup picom &
nohup redshift &
nohup syncthing -no-browser &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# /usr/lib/geoclue-2.0/demos/agent &    # dumb
nohup screenrotator &
# $HOME/bspwm/status.sh & # Initializes listeners for muse-status, probably already taken care of by muse-status
./autoworkspaces.sh
paplay $HOME/Drive/Music/MuseSounds/Hello.ogg &
