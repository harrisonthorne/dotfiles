{ config, lib, pkgs, ... }:

let
  colors = (import ./mod/colors.nix).solarizedDark;

  fontText = "Inter 12";

  # bemenu
  black = "#${colors.palette.background}e5";
  white = "#${colors.palette.foreground}";
  primary = "#${colors.palette.primary}e5";
  bemenuOpts = ''-H 32 --fn ${fontText} --tb '${black}' --tf '${primary}' --fb '${black}' --ff '${white}' --nb '${black}' --nf '${primary}' --hb '${primary}' --hf '${black}' --sb '${primary}' --sf '${white}' --scrollbar autohide -f -m all'';
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

  programs = import ./mod/programs.nix { inherit pkgs colors; };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  services = import ./mod/services.nix { inherit pkgs bemenuOpts colors; };

  wayland.windowManager.sway = import ./mod/sway/mod.nix { inherit config lib colors bemenuOpts; };

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
