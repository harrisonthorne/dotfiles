{ pkgs, ... }:

{
  dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
      size = "48x48";
    };
    settings = {
      global = {
        geometry = "";
        transparency = "90";
      };
    };
    waylandDisplay = "";
  };

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

  keybase.enable = true;

  kbfs = {
    enable = true;
  };

  spotifyd = {
    enable = true;
    settings = {
      global = {
        username_cmd = "pass spotify_username";
        password_cmd = "pass spotify";
        device_name = "spotifyd_ponytower";
        device_type = "computer";
        use_keyring = true;
        use_mpris = true;
        backend = "pulseaudio";
      };
    };
  };

  syncthing.enable = true;

  udiskie = {
    enable = true;
    automount = true;
    notify = true;
  };
}
