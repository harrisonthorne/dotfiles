{ pkgs, bemenuOpts, colors, ... }:

{
  enable = true;
  iconTheme = {
    package = pkgs.arc-icon-theme;
    name = "Arc";
    size = "48x48";
  };
  settings = {
    global = {
      browser = "firefox";
      dmenu = "bemenu -p 'Do what?' ${bemenuOpts}";
      ellipsize = "end";
      follow = "mouse";
      font = "Inter 12";
      foreground = "#${colors.palette.white}";
      format = "<b>%s</b>\\n%b";
      frame_color = "#${colors.palette.gray}e5";
      frame_width = 4;
      geometry = "512x512-0";
      highlight = "#${colors.palette.alert}";
      history_length = -1;
      horizontal_padding = 32;
      icon_position = "left";
      layer = "overlay";
      markup = "full";
      max_icon_size = 48;
      mouse_left = "do_action";
      mouse_middle = "close_current";
      mouse_right = "do_action";
      padding = 16;
      progress_bar_height = 4;
      separator_height = 4;
      show_age_threshold = "1m";
      show_indicators = false;
      sort = true;
      stack_duplicates = true;
      transparency = 10;
      word_wrap = true;
    };
    "urgency_low" = {
      background = "#${colors.palette.black}e5";
      foreground = "#${colors.palette.primary}";
    };
    "urgency_normal" = {
      background = "#${colors.palette.black}e5";
      foreground = "#${colors.palette.white}";
    };
    "urgency_critical" = {
      background = "#${colors.palette.black}e5";
      foreground = "#${colors.palette.white}";
      frame_color = "#${colors.palette.warning}e5";
      timeout = "10s";
    };
  };
  waylandDisplay = "";
}
