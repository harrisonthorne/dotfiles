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
    base10 = "999999";
    base11 = "aaaaaa";
    base12 = "bbbbbb";
    base13 = "cccccc";
    base14 = "dddddd";

    base07 = "eeeeee";
    base15 = "ffffff";

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
      primary = base14;
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
    base10 = "b58900";
    base11 = "859900";
    base12 = "2aa198";
    base13 = "268bd2";
    base14 = "6c71c4";
    base15 = "d33682";

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
      primary = base14;
      warning = "ffaa00";
      alert = "ff0000";
    };
  };
}
