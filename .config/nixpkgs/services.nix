{ pkgs, bemenuOpts, colors, ... }:

{
  dunst = import ./dunst.nix { inherit pkgs bemenuOpts colors; };

  gammastep = {
    enable = true;
    provider = "geoclue2";
    temperature = {
      night = 1500;
    };
    settings = {
      general = {
        adjustment-method = "wayland";
      };
    };
  };

  spotifyd = import ./spotifyd/mod.nix { inherit pkgs; };

  syncthing.enable = true;
}
