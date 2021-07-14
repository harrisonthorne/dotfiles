{ config, lib, colors, ... }: 

let
  sup = "Mod4";
  alt = "Mod1";

  sans = "Inter";

  # background colors
  black = "#${colors.color00}e5";
  gray = "#${colors.color08}e5";

  # foreground colors
  white = "#${colors.color15}";
  silver = "#${colors.color07}";

  # other colors
  active = "#${colors.active}e5";
  warning = "#ffaa00e5"; 
  transparent = "#00000000";

  bemenuOpts = ''-H 32 --fn ${sans} 12 --tb '${black}' --tf '${active}' --fb '${black}' --ff '${white}' --nb '${black}' --nf '${active}' --hb '${active}' --hf '${black}' --sb '${active}' --sf '${white}' --scrollbar autohide -f -m all'';
in {
  enable = true;
  config = {
    bars = [ {
      fonts = [ "${sans} 12" ];
      height = 32;
      modifier = "${sup}";
      position = "top";
      extraConfig = ''
      separator_symbol = "    "
      status_edge_padding = 16
      '';
      statusCommand = "muse-status sub a -m i3 -p ${white} -s ${active}";
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
    } ];

    colors = {
      background = black;
      focused = { border = gray; background = gray; text = white; indicator = active; };
      focused_inactive = { border = black; background = black; text = silver; indicator = black; };
      indicator = { border = black; background = black; text = active; };
      unfocused = { border = black; background = black; text = active; indicator = black; };
      urgent = { border = warning; background = warning; text = black; };
    };

    floating = {
      border = 6;
      titlebar = true;
    };

    focus = {
      followMouse = "always";
      newWindow = "smart";
    };

    fonts = [ "${sans} 12" ];

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

    keybindings = import ./keys.nix { inherit config lib sup bemenuOpts; };

    menu = "bemenu-run -p 'Run what?' ${bemenuOpts}";

    # no modes
    modes = { };

    terminal = "kitty";

    window = {
      titlebar = true;
      hideEdgeBorders = "smart";
      border = 6;
    };

    workspaceAutoBackAndForth = true;
  };
  extraConfig = builtins.readFile ../files/sway/config;
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
  '';
  wrapperFeatures = {
    gtk = true;
  };
};
