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
    shellInit = builtins.readFile ../files/fish/init.fish;
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
      foreground #${colors.palette.foreground}
      background #${colors.palette.background}

      color0 #${colors.base00}
      color1 #${colors.base01}
      color2 #${colors.base02}
      color3 #${colors.base03}
      color4 #${colors.base04}
      color5 #${colors.base05}
      color6 #${colors.base06}
      color7 #${colors.base07}
      color8 #${colors.base08}
      color9 #${colors.base09}
      color10 #${colors.base10}
      color11 #${colors.base11}
      color12 #${colors.base12}
      color13 #${colors.base13}
      color14 #${colors.base14}
      color15 #${colors.base15}
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
