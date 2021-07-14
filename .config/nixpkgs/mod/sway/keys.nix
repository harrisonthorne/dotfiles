{ config, lib, sup, alt, bemenuOpts, lockCmd, ... }:

let
  execWithShell = "-e ${shell} -i -p";
  notebookDir = "$HOME/notebook/";
  shell = "fish";
  terminal = config.wayland.windowManager.sway.config.terminal;

  # apps
  browser = "firefox";
  music = "${terminal} ${execWithShell} spt";
  email = "evolution";
  media = "kodi --windowing=x11";
in {
  # power controls
  "${sup}+Control+${alt}+p" = "exec systemctl poweroff";
  "${sup}+Control+${alt}+r" = "exec systemctl reboot";
  "${sup}+Control+${alt}+s" = "exec systemctl suspend";
  "${sup}+Control+${alt}+b" = "exec systemctl hibernate";
  
  # change focus
  "${sup}+h" = "focus left";
  "${sup}+j" = "focus down";
  "${sup}+k" = "focus up";
  "${sup}+l" = "focus right";
  "${sup}+Left" = "focus left";
  "${sup}+Down" = "focus down";
  "${sup}+Up" = "focus up";
  "${sup}+Right" = "focus right";
  "${sup}+Tab" = "focus next";
  "${sup}+Shift+Tab" = "focus prev";
  
  # move focused window
  "${sup}+Shift+h" = "move left";
  "${sup}+Shift+j" = "move down";
  "${sup}+Shift+k" = "move up";
  "${sup}+Shift+l" = "move right";
  "${sup}+Shift+Left" = "move left";
  "${sup}+Shift+Down" = "move down";
  "${sup}+Shift+Up" = "move up";
  "${sup}+Shift+Right" = "move right";
  
  # move focused workspace to outputs
  "${sup}+Control+h" = "move workspace to left";
  "${sup}+Control+j" = "move workspace to down";
  "${sup}+Control+k" = "move workspace to up";
  "${sup}+Control+l" = "move workspace to right";
  "${sup}+Control+Left" = "move workspace to left";
  "${sup}+Control+Down" = "move workspace to down";
  "${sup}+Control+Up" = "move workspace to up";
  "${sup}+Control+Right" = "move workspace to right";
  
  # quick resize
  "${sup}+${alt}+h" = "resize shrink width 20 px";
  "${sup}+${alt}+j" = "resize grow height 20 px";
  "${sup}+${alt}+k" = "resize shrink height 20 px";
  "${sup}+${alt}+l" = "resize grow width 20 px";
  "${sup}+${alt}+Left" = "resize shrink width 20 px";
  "${sup}+${alt}+Down" = "resize grow height 20 px";
  "${sup}+${alt}+Up" = "resize shrink height 20 px";
  "${sup}+${alt}+Right" = "resize grow width 20 px";
  
  # close window
  "${sup}+q" = "kill";
  
  # switch between floating/tiled layers
  "${sup}+z" = "focus mode_toggle";
  "${sup}+Shift+z" = "focus parent";
  "${sup}+Control+z" = "focus child";
  
  # change container layout
  "${sup}+t" = "layout tabbed";
  "${sup}+y" = "layout toggle split";
  "${sup}+u" = "layout stacking";
  "${sup}+o" = "split toggle";
  "${sup}+f" = "fullscreen toggle";
  
  # shortcuts for apps
  "${sup}+Control+e" = "exec $HOME/.config/sway/emoji_menu.fish ${bemenuOpts}";
  "${sup}+Control+n" = ''exec ${terminal} -d ${notebookDir} ${execWithShell} "nvim ${notebookDir}/new/(date +%Y%m%d-%H%M%S).md"'';
  "${sup}+Control+p" = "exec pavucontrol";
  "${sup}+Control+r" = "exec sh $HOME/.config/toggle_gammastep.sh";
  "${sup}+Return" = "exec ${terminal}";
  "${sup}+Shift+b" = ''exec ${terminal} -d ${notebookDir} ${execWithShell} "nvim ${notebookDir}/bored.md"'';
  "${sup}+Shift+m" = "exec ${media}";
  "${sup}+Shift+n" = ''exec ${terminal} -d ${notebookDir} ${execWithShell} "ranger ${notebookDir}"'';
  "${sup}+a" = "exec ${config.wayland.windowManager.sway.config.menu}";
  "${sup}+c" = "exec ${terminal} ${execWithShell} qalc";
  "${sup}+b" = "exec ${music}";
  "${sup}+e" = "exec ${terminal} ${execWithShell} ranger";
  "${sup}+n" = "exec ${terminal} ${execWithShell} nvim";
  "${sup}+p" = "exec ${terminal} ${execWithShell} htop";
  "${sup}+w" = "exec ${browser}";
  
  # lock
  "${sup}+Escape" = "exec ${lockCmd}";
  
  # notifications
  "${sup}+Minus" = "exec makoctl dismiss";
  "${sup}+Equal" = "exec makoctl restore";
  "${sup}+Space" = ''exec makoctl menu bemenu -p "Do what?" ${bemenuOpts}'';
  
  # toggle floating. also set border in case we're coming from floating video mode
  "${sup}+s" = "floating toggle; border normal 6";
  
  # floating video mode
  "${sup}+i" = "fullscreen disable,\\
  floating enable,\\
  sticky enable,\\
  border pixel 6,\\
  resize set 356 200,\\
  move position 1564 px 0 px,\\
  inhibit_idle open";
  "${sup}+Shift+i" = "fullscreen disable,\\
  floating enable,\\
  sticky enable,\\
  border pixel 6,\\
  resize set 711 400,\\
  move position 1209 px 0 px,\\
  inhibit_idle open";
  
  # switch to workspace
  "${sup}+1" = "workspace $ws1";
  "${sup}+2" = "workspace $ws2";
  "${sup}+3" = "workspace $ws3";
  "${sup}+4" = "workspace $ws4";
  "${sup}+5" = "workspace $ws5";
  "${sup}+6" = "workspace $ws6";
  "${sup}+7" = "workspace $ws7";
  "${sup}+8" = "workspace $ws8";
  "${sup}+9" = "workspace $ws9";
  "${sup}+0" = "workspace $ws10";
  
  # move focused container to workspace
  "${sup}+Shift+1" = "move container to workspace $ws1";
  "${sup}+Shift+2" = "move container to workspace $ws2";
  "${sup}+Shift+3" = "move container to workspace $ws3";
  "${sup}+Shift+4" = "move container to workspace $ws4";
  "${sup}+Shift+5" = "move container to workspace $ws5";
  "${sup}+Shift+6" = "move container to workspace $ws6";
  "${sup}+Shift+7" = "move container to workspace $ws7";
  "${sup}+Shift+8" = "move container to workspace $ws8";
  "${sup}+Shift+9" = "move container to workspace $ws9";
  "${sup}+Shift+0" = "move container to workspace $ws10";
  
  # scratchpad (minimize)
  "${sup}+v" = "move scratchpad";
  "${sup}+Shift+v" = "scratchpad show";
  
  # reload with same or random wallpaper
  "${sup}+Shift+r" = "exec wpg -s $(wpg -c)";
  "${sup}+Control+w" = "exec wpg -m";
  
  # record clock times (easy clock-in or clock-out :))
  "${sup}+Delete" = "exec ${notebookDir}/record_time.fish";
  "${sup}+Home" = "exec ${notebookDir}/record_time.fish '(clock-in)'";
  "${sup}+End" = "exec ${notebookDir}/record_time.fish '(clock-out)'";
  "${sup}+Shift+Delete" = "exec ~/.config/sway/prompt_timestamp.fish ${bemenuOpts}";
  "${sup}+Shift+Home" = "exec ~/.config/sway/prompt_clock_in.fish ${bemenuOpts}";
  "${sup}+Shift+End" = "exec ~/.config/sway/prompt_clock_out.fish ${bemenuOpts}";
  
  # exit sway
  "${sup}+Shift+e" = ''exec "pw-play $HOME/.nix-profile/share/sounds/musicaflight/stereo/Goodbye.oga; swaymsg exit"'';
  
  # not to be removed until i learn
  "Control+Escape" = ''exec notify-send "Silly goose" "You replaced Ctrl+Esc with Super+Minus, remember?"'';
}
