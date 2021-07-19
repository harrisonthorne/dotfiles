{ pkgs, colors, ... }:

{
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

    # use base16 colors
    extraConfig = ''
      foreground #${colors.palette.foreground}
      background #${colors.palette.background}

      selection_background #${colors.base05}
      selection_foreground #${colors.base00}
      url_color #${colors.base04}
      cursor #${colors.base05}
      active_border_color #${colors.base03}
      inactive_border_color #${colors.base01}
      active_tab_background #${colors.base00}
      active_tab_foreground #${colors.base05}
      inactive_tab_background #${colors.base01}
      inactive_tab_foreground #${colors.base04}
      tab_bar_background #${colors.base01}

      color0 #${colors.base00}
      color1 #${colors.base08}
      color2 #${colors.base0B}
      color3 #${colors.base0A}
      color4 #${colors.base0D}
      color5 #${colors.base0E}
      color6 #${colors.base0C}
      color7 #${colors.base04}
      color8 #${colors.base01}
      color9 #${colors.base09}
      color10 #${colors.base02}
      color11 #${colors.base03}
      color12 #${colors.base06}
      color13 #${colors.base07}
      color14 #${colors.base0F}
      color15 #${colors.base05}
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
}
