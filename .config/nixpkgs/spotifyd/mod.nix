{ pkgs, ... }:

with (import ./spotify-info.nix); {
  enable = true;
  package = pkgs.spotifyd.override {
    withPulseAudio = true;
    withMpris = true;
  };
  settings = {
    global = {
      username = username;
      password_cmd = "pass spotify";
      device_name = deviceName;
      device_type = "computer";
      use_keyring = true;
      use_mpris = true;
      backend = "pulseaudio";
    };
  };
}
