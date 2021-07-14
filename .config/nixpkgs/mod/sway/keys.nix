{
  # power controls
  "$mod+Control+$alt+p" = "exec systemctl poweroff"
  "$mod+Control+$alt+r" = "exec systemctl reboot"
  "$mod+Control+$alt+s" = "exec systemctl suspend"
  "$mod+Control+$alt+b" = "exec systemctl hibernate"
  
  # change focus
  "$mod+h" = "focus left";
  "$mod+j" = "focus down";
  "$mod+k" = "focus up";
  "$mod+l" = "focus right";
  "$mod+Left" = "focus left";
  "$mod+Down" = "focus down";
  "$mod+Up" = "focus up";
  "$mod+Right" = "focus right";
  "$mod+Tab" = "focus next";
  "$mod+Shift+Tab" = "focus prev";
  
  # move focused window
  "$mod+Shift+h" = "move left";
  "$mod+Shift+j" = "move down";
  "$mod+Shift+k" = "move up";
  "$mod+Shift+l" = "move right";
  "$mod+Shift+Left" = "move left";
  "$mod+Shift+Down" = "move down";
  "$mod+Shift+Up" = "move up";
  "$mod+Shift+Right" = "move right";
  
  # move focused workspace to outputs
  "$mod+Control+h" = "move workspace to left";
  "$mod+Control+j" = "move workspace to down";
  "$mod+Control+k" = "move workspace to up";
  "$mod+Control+l" = "move workspace to right";
  "$mod+Control+Left" = "move workspace to left";
  "$mod+Control+Down" = "move workspace to down";
  "$mod+Control+Up" = "move workspace to up";
  "$mod+Control+Right" = "move workspace to right";
  
  # quick resize
  "$mod+$alt+h" = "resize shrink width 20 px";
  "$mod+$alt+j" = "resize grow height 20 px";
  "$mod+$alt+k" = "resize shrink height 20 px";
  "$mod+$alt+l" = "resize grow width 20 px";
  "$mod+$alt+Left" = "resize shrink width 20 px";
  "$mod+$alt+Down" = "resize grow height 20 px";
  "$mod+$alt+Up" = "resize shrink height 20 px";
  "$mod+$alt+Right" = "resize grow width 20 px";
  
  # close window
  "$mod+q" = "kill";
  
  # switch between floating/tiled layers
  "$mod+z" = "focus mode_toggle";
  "$mod+Shift+z" = "focus parent";
  "$mod+Control+z" = "focus child";
  
  # change container layout
  "$mod+t" = "layout tabbed";
  "$mod+y" = "layout toggle split";
  "$mod+u" = "layout stacking";
  "$mod+o" = "split toggle";
  "$mod+f" = "fullscreen toggle";
  
  # shortcuts for apps
  "$mod+Control+e" = "exec $HOME/.config/sway/emoji_menu.fish $bemenu_opts";
  "$mod+Control+n" = ''exec $terminal -d $notebook_dir $exec_with_shell "nvim $notebook_dir/new/(date +%Y%m%d-%H%M%S).md"'';
  "$mod+Control+p" = "exec pavucontrol";
  "$mod+Control+r" = "exec sh $HOME/.config/toggle_gammastep.sh";
  "$mod+Return" = "exec $terminal";
  "$mod+Shift+b" = ''exec $terminal -d $notebook_dir $exec_with_shell "nvim $notebook_dir/bored.md"'';
  "$mod+Shift+m" = "exec $media";
  "$mod+Shift+n" = ''exec $terminal -d $notebook_dir $exec_with_shell "ranger $notebook_dir"'';
  "$mod+a" = "exec $menu";
  "$mod+c" = "exec $terminal $exec_with_shell qalc";
  "$mod+b" = "exec $music";
  "$mod+e" = "exec $terminal $exec_with_shell ranger";
  "$mod+n" = "exec $terminal $exec_with_shell nvim";
  "$mod+p" = "exec $terminal $exec_with_shell htop";
  "$mod+w" = "exec $browser";
  
  # lock
  "$mod+Escape" = "exec $lock";
  
  # notifications
  "$mod+Minus" = "exec makoctl dismiss";
  "$mod+Equal" = "exec makoctl restore";
  "$mod+Space" = ''exec makoctl menu bemenu -p "Do what?" $bemenu_opts'';
  
  # toggle floating. also set border in case we're coming from floating video mode
  "$mod+s" = "floating toggle; border normal 6";
  
  # floating video mode
  "$mod+i" = "fullscreen disable,\
  floating enable,\
  sticky enable,\
  border pixel 6,\
  resize set 356 200,\
  move position 1564 px 0 px,\
  inhibit_idle open";
  "$mod+Shift+i" = "fullscreen disable,\
  floating enable,\
  sticky enable,\
  border pixel 6,\
  resize set 711 400,\
  move position 1209 px 0 px,\
  inhibit_idle open";
  
  # switch to workspace
  "$mod+1" = "workspace $ws1";
  "$mod+2" = "workspace $ws2";
  "$mod+3" = "workspace $ws3";
  "$mod+4" = "workspace $ws4";
  "$mod+5" = "workspace $ws5";
  "$mod+6" = "workspace $ws6";
  "$mod+7" = "workspace $ws7";
  "$mod+8" = "workspace $ws8";
  "$mod+9" = "workspace $ws9";
  "$mod+0" = "workspace $ws10";
  
  # move focused container to workspace
  "$mod+Shift+1" = "move container to workspace $ws1";
  "$mod+Shift+2" = "move container to workspace $ws2";
  "$mod+Shift+3" = "move container to workspace $ws3";
  "$mod+Shift+4" = "move container to workspace $ws4";
  "$mod+Shift+5" = "move container to workspace $ws5";
  "$mod+Shift+6" = "move container to workspace $ws6";
  "$mod+Shift+7" = "move container to workspace $ws7";
  "$mod+Shift+8" = "move container to workspace $ws8";
  "$mod+Shift+9" = "move container to workspace $ws9";
  "$mod+Shift+0" = "move container to workspace $ws10";
  
  # scratchpad (minimize)
  "$mod+v" = "move scratchpad";
  "$mod+Shift+v" = "scratchpad show";
  
  # reload with same or random wallpaper
  "$mod+Shift+r" = "exec wpg -s $(wpg -c)";
  "$mod+Control+w" = "exec wpg -m";
  
  # record clock times (easy clock-in or clock-out :))
  "$mod+Delete" = "exec $notebook_dir/record_time.fish";
  "$mod+Home" = "exec $notebook_dir/record_time.fish '(clock-in)'";
  "$mod+End" = "exec $notebook_dir/record_time.fish '(clock-out)'";
  "$mod+Shift+Delete" = "exec ~/.config/sway/prompt_timestamp.fish $bemenu_opts";
  "$mod+Shift+Home" = "exec ~/.config/sway/prompt_clock_in.fish $bemenu_opts";
  "$mod+Shift+End" = "exec ~/.config/sway/prompt_clock_out.fish $bemenu_opts";
  
  # exit sway
  "$mod+Shift+e" = ''exec "pw-play $HOME/.nix-profile/share/sounds/musicaflight/stereo/Goodbye.oga; swaymsg exit"'';
  
  # not to be removed until i learn
  "Control+Escape" = ''exec notify-send "Silly goose" "You replaced Ctrl+Esc with Super+Minus, remember?"'';
}
