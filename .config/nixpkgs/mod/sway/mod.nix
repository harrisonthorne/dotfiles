{ config, lib, colors, ... }:

let
  sup = "Mod4";
  alt = "Mod1";

  font = {
    names = [ "Inter" ];
    style = "Regular";
    size = 12.0;
  };
  fontText = "Inter 12";

  # background colors
  black = "#${colors.color00}e5";
  gray = "#${colors.color08}e5";

  # foreground colors
  white = "#${colors.color15}";
  silver = "#${colors.color07}";

  # other colors
  active = "#${colors.active}e5";
  warning = "#ffaa00e5";

  bemenuOpts = ''-H 32 --fn ${fontText} --tb '${black}' --tf '${active}' --fb '${black}' --ff '${white}' --nb '${black}' --nf '${active}' --hb '${active}' --hf '${black}' --sb '${active}' --sf '${white}' --scrollbar autohide -f -m all'';
  lockCmd = "$HOME/.config/sway/lock.sh";

  dpmsOff = "swaymsg 'output * dpms off'";
  dpmsOn = "swaymsg 'output * dpms on'";
in
{
  enable = true;
  config = {
    bars = [{
      fonts = font;
      position = "top";
      extraConfig = ''
        separator_symbol "    "
        status_edge_padding 16
        height 32
        modifier "${sup}"
      '';
      statusCommand = "muse-status sub a -m i3 -p ${colors.color15} -s ${colors.active}";
      trayOutput = "none";
      workspaceButtons = true;
      colors = {
        activeWorkspace = { background = black; border = black; text = silver; };
        background = black;
        bindingMode = { background = black; border = black; text = warning; };
        focusedWorkspace = { background = black; border = black; text = white; };
        statusline = white;
        inactiveWorkspace = { background = black; border = black; text = active; };
        separator = active;
        urgentWorkspace = { background = warning; border = warning; text = black; };
      };
    }];

    colors = {
      background = black;
      focused = { border = gray; background = gray; text = white; indicator = active; childBorder = gray; };
      focusedInactive = { border = black; background = black; text = silver; indicator = black; childBorder = black; };
      unfocused = { border = black; background = black; text = active; indicator = black; childBorder = black; };
      urgent = { border = warning; background = warning; text = black; indicator = active; childBorder = warning; };
    };

    floating = {
      border = 6;
      titlebar = true;
    };

    focus = {
      followMouse = "always";
      newWindow = "smart";
    };

    fonts = font;

    gaps = {
      inner = 16;
      smartBorders = "on";
      smartGaps = true;
    };

    input = {
      "2:7:SynPS/2_Synaptics_TouchPad" = {
        tap = "enabled";
        natural_scroll = "enabled";
      };

      "1267:9527:ELAN0732:00_04F3:2537" = {
        map_to_output = "eDP-1";
      };

      "*" = {
        xkb_layout = "us";
      };
    };

    keybindings = import ./keys.nix { inherit config lib sup alt bemenuOpts lockCmd; };

    menu = "bemenu-run -p 'Run what?' ${bemenuOpts}";

    # no modes
    modes = { };

    modifier = "${sup}";

    output = {
      # for laptop
      "eDP-1" = {
        pos = "0 0";
      };

      # for ponytower
      "Acer Technologies SB220Q 0x00007C0D" = {
        pos = "0 0";
      };
      "Acer Technologies SB220Q 0x000035FB" = {
        pos = "1920 0";
      };

      # for all
      "*" = {
        background = ''"$HOME/.config/wpg/wallpapers/$(wpg -c)" fill'';
      };
    };

    # startup apps
    startup =
      let
        wobBorder = "#e5${colors.color08}";
        wobBar = "#ff${colors.active}";
        wobBackground = "#e5${colors.color00}";
        lockWarningCmd = "notify-send -u low -t 29500 -- 'Are you still there?' 'Your system will lock itself soon.'";
      in
      [
        { command = ''/run/current-system/sw/libexec/xdg-desktop-portal-wlr''; }
        { command = ''/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1''; }
        { command = ''brillo -I''; }
        { command = ''muse-status-daemon''; }
        { command = ''swayidle -w timeout 270 ${lockWarningCmd} timeout 300 ${lockCmd} timeout 315 ${dpmsOff} resume ${dpmsOn} before-sleep ${lockCmd}''; }
        { command = ''xhost si:localuser:root''; }
        { command = ''xrdb -load ~/.Xresources''; }

        # this might let gammastep start correctly
        { command = ''systemctl --user import-environment''; }
        { command = ''systemctl --user start graphical-session.target''; }

        # (re)start wob
        { command = "killall wob; mkfifo $SWAYSOCK.wob; tail -f $SWAYSOCK.wob | wob -a bottom -H 24 -W 512 -M 256 -p 4 -o 0 -b 6 --border-color '${wobBorder}' --bar-color '${wobBar}' --background-color '${wobBackground}'"; always = true; }

        # play startup sound
        { command = ''canberra-gtk-play --id=desktop-login''; }
      ];

    terminal = "kitty";

    window = {
      border = 6;
      hideEdgeBorders = "smart";
      titlebar = true;

      commands = [
        { command = "floating enable, resize set 64 px 32 px, move position 256 px -70 px, border csd"; criteria = { title = "Firefox — Sharing Indicator"; }; }
        { command = "floating enable, resize set 600 px 400 px"; criteria = { title = "Page Unresponsive"; }; }
        { command = "floating enable, sticky enable, resize set 30 ppt 60 ppt"; criteria = { app_id = "^launcher$"; }; }
        { command = "inhibit_idle fullscreen"; criteria = { class = ".*"; }; }
      ];
    };

    workspaceAutoBackAndForth = true;
  };
  extraConfig = builtins.readFile ../../files/sway/config;
  extraSessionCommands = ''
    export CLUTTER_BACKEND=wayland
    export ECORE_EVAS_ENGINE=wayland-egl
    export ELM_ENGINE=wayland_egl
    export MOZ_ENABLE_WAYLAND=1
    export NO_AT_BRIDGE=1
    export QT_QPA_PLATFORM=wayland-egl
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export SDL_VIDEODRIVER=wayland
    export _JAVA_AWT_WM_NONREPARENTING=1
    export XDG_CURRENT_DESKTOP=sway 
    export XDG_SESSION_TYPE=wayland 
  '';
  wrapperFeatures = {
    gtk = true;
  };
}
