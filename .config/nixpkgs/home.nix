# vim: ts=2 sw=2 expandtab
{ config, pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home.packages = with pkgs; [
    # desktop environment
    bemenu
    bibata-cursors
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
    neovim-remote
    notify-desktop
    pinentry
    pinentry-curses
    playerctl
    ranger
    ripgrep
    sd
    zip

    # programming
    docker-compose
    gcc
    nodejs
    python3
    rustup
    tree-sitter

    # sound
    pamixer

    # apps
    android-file-transfer
    awf
    element-desktop
    gimp
    inkscape
    imv
    keepassxc
    kodi
    mpv-with-scripts
    pavucontrol
    signal-desktop
    slack
    spotify
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Arc-Dark";
      icon-theme = "Arc";
      cursor-theme = "Vanilla-DMZ-AA";
      font-name = "Inter 12";
    };
    "org/gnome/desktop/sound" = {
      theme-name = "musicaflight";
      event-sounds = true;
      input-feedback-sounds = true;
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
      gtk-cursor-theme-name="Vanilla-DMZ-AA"
      gtk-cursor-theme-size=24
    '';
    gtk3.extraConfig = {
      gtk-cursor-theme-name = "Vanilla-DMZ-AA";
      gtk-cursor-theme-size = 24;
    };
  };

  manual.html.enable = true;

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    bat.enable = true;

    firefox.enable = true;

    # fish = {
    #   enable = true;

    # };

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

    kitty = {
      enable = true;
      extraConfig = ''
        include ~/.cache/wal/colors-kitty.conf
      '';
      font = with pkgs; {
        package = iosevka;
        name = "Iosevka";
        size = 11;
      };
      settings = {
        bold_font = "Iosevka Bold";
        italic_font = "Iosevka Italic";
        bold_italic_font = "Iosevka Bold Italic";
      };
    };

    skim = {
      enable = true;
      enableFishIntegration = true;
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
      settings = {
        general = {
          adjustment-method = "wayland";
        };
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
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ-AA";
      size = 24;
    };
  };
}
