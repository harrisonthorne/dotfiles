# colors based on the base16 spec
{
  # monochrome colors

  monochrome = rec {
    base00 = "000000";
    base08 = "111111";

    base01 = "222222";
    base02 = "333333";
    base03 = "444444";
    base04 = "555555";
    base05 = "666666";
    base06 = "777777";
    base09 = "888888";
    base0A = "999999";
    base0B = "aaaaaa";
    base0C = "bbbbbb";
    base0D = "cccccc";
    base0E = "dddddd";

    base07 = "eeeeee";
    base0F = "ffffff";

    palette = {
      # background bases
      background = base00;
      black = base00;
      gray = base02;

      # foreground bases
      foreground = base05;
      white = base05;
      silver = base04;

      # other bases
      primary = base0D;
      warning = "ffaa00";
      alert = "ff0000";
    };
  };

  # solarized dark
  solarizedDark = rec {
    base00 = "002b36";
    base01 = "073642";
    base02 = "586e75";
    base03 = "657b83";
    base04 = "839496";
    base05 = "93a1a1";
    base06 = "eee8d5";
    base07 = "fdf6e3";
    base08 = "dc322f";
    base09 = "cb4b16";
    base0A = "b58900";
    base0B = "859900";
    base0C = "2aa198";
    base0D = "268bd2";
    base0E = "6c71c4";
    base0F = "d33682";

    palette = {
      # background bases
      background = base00;
      black = base00;
      gray = base01;

      # foreground bases
      foreground = base06;
      white = base06;
      silver = base05;

      # other bases
      primary = base0C;
      warning = "ffaa00";
      alert = "ff0000";
    };
  };
}
