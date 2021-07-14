{ config, lib, pkgs, ... }:

let
  colors = import ./mod/colors.nix;
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    packages = with pkgs; [
      # desktop environment
      bemenu
      bibata-cursors
      grim
      ksshaskpass
      polkit_gnome
      slurp
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
      neovim
      neovim-remote
      notify-desktop
      pinentry
      pinentry-curses
      playerctl
      ranger
      ripgrep
      sd
      spotify-tui
      zip

      # fish plugins
      fishPlugins.done
      fishPlugins.foreign-env

      # programming
      docker-compose
      gcc
      nodejs
      nodePackages.npm
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

      # other
      xorg.xcursorgen
    ];

    extraOutputsToInstall = [ "doc" "info" "devdoc" ];
    sessionPath = [
      "$HOME/.npm-global/bin"
      "$HOME/.npm-packages/bin"
      "$HOME/.cargo/bin"
      "$HOME/.local/bin"
      "$HOME/go/bin"
      "${config.home.sessionVariables.TEXLIVE_PATH}"
    ];
    sessionVariables = {
      # from fish
      ANDROID_EMULATOR_USE_SYSTEM_LIBS = 1;
      BAT_THEME = "base16";
      BEMENU_BACKEND = "wayland";
      BROWSER = "firefox";
      EDITOR = "nvim";
      EIX_LIMIT = 0;
      FZF_DEFAULT_COMMAND = ''ag --hidden --ignore .git --ignore node_modules -g ""'';
      GPG_TTY = "$(tty)";
      GTK_THEME = "Arc-Dark";
      LEDGER_FILE = "$HOME/Notebook/ledger/main.sfox";
      SUDO_ASKPASS = "pass spotify";
      TEXLIVE_PATH = "/opt/texlive/2021/bin/x86_64-linux/";
      WINEPREFIX = "$HOME/.wine/";
      XBPS_DISTDIR = "$HOME/code/void/packages";
    };

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
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

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Arc-Dark";
      icon-theme = "Arc";
      cursor-theme = "Bibata_Classic";
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
      gtk-cursor-theme-name="Bibata_Classic"
      gtk-cursor-theme-size=24
    '';
    gtk3.extraConfig = {
      gtk-cursor-theme-name = "Bibata_Classic";
      gtk-cursor-theme-size = 24;
    };
  };

  manual.html.enable = true;

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    bat.enable = true;

    command-not-found.enable = true;

    exa = {
      enable = true;
      enableAliases = true;
    };

    firefox.enable = true;

    fish = {
      enable = true;
      shellInit = builtins.readFile ./files/fish/init.fish;
    };

    git = {
      enable = true;
      signing = {
        key = "4B21310A52B15162";
        signByDefault = true;
      };
      userEmail = "harrisonthorne@protonmail.com";
      userName = "Harrison Thorne";
      extraConfig = {
        url = {
          "git@github.com:".insteadOf = "https://github.com/";
          "git@bitbucket.org:".insteadOf = "https://bitbucket.org/";
          "git@codeberg.org:".insteadOf = "https://codeberg.org/";
        };
        diff = {
          tool = "vimdiff2";
          colorMoved = "zebra";
        };
        fetch.prune = true;
        pull.rebase = true;
        lfs = {
          enable = true;
        };
        color = {
          ui = "auto";
          diff = {
            old = 196;
            new = 48;
            oldMoved = 201;
            newMoved = 226;
          };
        };
        init.defaultBranch = "main";
        merge.renamelimit = 2016;
      };
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
        foreground #${colors.color15}
        background #${colors.color00}

        color0 #${colors.color00}
        color1 #${colors.color01}
        color2 #${colors.color02}
        color3 #${colors.color03}
        color4 #${colors.color04}
        color5 #${colors.color05}
        color6 #${colors.color06}
        color7 #${colors.color07}
        color8 #${colors.color08}
        color9 #${colors.color09}
        color10 #${colors.color10}
        color11 #${colors.color11}
        color12 #${colors.color12}
        color13 #${colors.color13}
        color14 #${colors.color14}
        color15 #${colors.color15}
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
        background_opacity = "0.90";
      };
    };

    password-store = {
      enable = true;
      settings = {
        PASSWORD_STORE_DIR = "$HOME/.password-store";
        PASSWORD_STORE_KEY = "4B21310A52B15162";
      };
    };

    skim = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = ''fd --type f'';
    };

    texlive = {
      enable = true;
    };

    tmux = {
      enable = true;
      shortcut = "a";
    };

    zathura.enable = true;

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  services = {
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
  };

  wayland.windowManager.sway = import ./mod/sway/mod.nix { inherit config lib colors; };

  xdg.enable = true;

  xsession = {
    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata_Classic";
      size = 24;
    };
  };
}

# vim: ts=2 sw=2 expandtab
