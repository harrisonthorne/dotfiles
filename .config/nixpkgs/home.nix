# vim: ts=2 sw=2 expandtab
{ config, pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    font = {
      package = pkgs.inter-ui;
      name = "Inter";
      size = 12;
    };
    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
    };
    theme = {
      package = pkgs.arc-theme;
      name = "Arc-Dark";
    };
    gtk2.extraConfig = ''
      gtk-cursor-theme-name="capitaine-cursors"
      gtk-cursor-theme-size=24
    '';
    gtk3.extraConfig = {
      gtk-cursor-theme-name = "capitaine-cursors";
      gtk-cursor-theme-size = 24;
    };
  };

  home.packages = with pkgs; [
    # desktop environment
    bemenu
    capitaine-cursors
    grim
    mako
    polkit_gnome
    slurp
    sway
    swaybg
    swayidle
    swaylock
    wl-clipboard
    wob
    wpgtk
    xdg-desktop-portal-wlr

    # terminal stuff
    fd
    fish
    gnupg
    kitty
    neovim
    notify-desktop
    ranger
    sd

    # programming
    docker-compose
    gcc
    nodejs
    rustup
    tree-sitter

    # sound
    pamixer
    playerctl

    # apps
    android-file-transfer
    gimp
    keepassxc
    kodi
    signal-desktop
    slack
    spotify
  ];

  manual.html.enable = true;

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    bat.enable = true;
    firefox.enable = true;
    skim = {
      enable = true;
      enableFishIntegration = true;
    };
    git = {
      enable = true;
      signing = {
        key = "4B21310A52B15162";
        signByDefault = true;
      };
      userEmail = "harrisonthorne@protonmail.com";
      userName = "Harrison Thorne";
    };
    gpg = {
      enable = true;
    };
    htop.enable = true;
    jq.enable = true;
    keychain = {
      enable = true;
      enableFishIntegration = true;
      agents = [ "gpg" "ssh" ];
      extraFlags = [ "-q" "--gpg2" ];
      keys = [ "id_rsa_github" "id_rsa_bitbucket" "id_ed25519" "4B21310A52B15162" ];
    };
    zathura.enable = true;
  };

  services = {
    gammastep = {
      enable = true;
      provider = "geoclue2";
      temperature = {
        night = 1500;
      };
    };
    syncthing.enable = true;
    udiskie = {
      enable = true;
      automount = true;
      notify = true;
    };
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "harrison";
    homeDirectory = "/home/harrison";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "21.11";
  };

  xsession = {
    pointerCursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
      size = 24;
    };
  };
}
