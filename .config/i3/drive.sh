alacritty -t "Google Drive sync" -e /usr/bin/fish -i -c "cd $HOME/drive && grive && notify-send 'Google Drive sync finished' 'Your files and folders are done syncing.' && exit"
