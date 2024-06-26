{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true; # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "devin";
  home.homeDirectory = "/home/devin";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    firefox
    bat
    zoxide
    gh
    thefuck
    clang
    ntfs3g
    youtube-music
    wl-clipboard
    just
    ripgrep
    python3
    vlc
    nodejs_20
    ffmpeg-full
    ttyper
    sidequest
    kdePackages.kalk
    jdk
    gradle
    zoom-us
    osu-lazer-bin
    bun
    godot_4
    obs-studio
    yt-dlp
    wineWowPackages.waylandFull
    chromium
    tree-sitter
    magic-wormhole
    btop
    nushell
    unzip

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/nushell" = {
      recursive = true;
      source = ../../common-config/nu;
    };

    "Pictures" = {
      recursive = true;
      source = ./Pictures;
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/devin/etc/profile.d/hm-session-vars.sh
  #

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Devin Droddy";
    userEmail = "devin.droddy@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "[┌<$all](bold green)";
      character = {
        success_symbol = "[└>](bold green)";
        error_symbol = "[└>](bold red)";
      };
      cmd_duration.min_time = 0;
    };
  };

  programs.bacon = {
    enable = true;
    settings = {
      keybindings = {
        g = "scroll-to-top";
        j = "scroll-lines(1)";
        k = "scroll-lines(-1)";
        shift-g = "scroll-to-bottom";
      };
    };
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  home.pointerCursor =
   let
     getFrom = url: hash: name: {
       gtk.enable = true;
       name = name;
       package = pkgs.runCommand "moveUp" { } ''
         mkdir -p $out/share/icons
         ln -s ${pkgs.fetchzip {
           url = url;
           hash = hash;
         }} $out/share/icons/${name}
       '';
     };
   in
   getFrom
     "https://cdn.discordapp.com/attachments/698251081569927191/1222751288941477978/posy-s-cursor.tar.xz?ex=6669c0a0&is=66686f20&hm=5216a32cd2d9cb0b883cba580f409c0cf3a1853d5a2d3bb29acc35e852be6942&"
     "sha256-eeL9+3dcTX99xtUivfYt23R/jh8VIVqtMkoUPmk/12E="
     "Posy";

  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.monaspace;
      name = "Monaspace Neon";
    };
    theme = "Dark Pastel";
    settings = {
      enabled_layouts = "tall";
      font_features = "MonaspaceNeon-Regular +calt +ss01 +ss02 +ss03 +ss04 +ss05 +ss07 +ss08 +liga";
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      keybinding = {
        universal = {
          prevItem-alt = "e";
          nextItem-alt = "n";
          prevBlock-alt = "m";
          nextBlock-alt = "i";
          scrollUpMain-alt1 = "E";
          scrollDownMain-alt1 = "N";
          scrollLeft = "M";
          scrollRight = "I";
        };
        files = {
          ignoreFile = "<disabled>";
        };
        branches = {
          viewGitFlowOptions = "<disabled>";
        };
        submodules = {
          init = "<disabled>";
        };
        commits = {
          startInteractiveRebase = "<disabled>";
        };
      };
    };
  };

  programs.fastfetch = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile ../../common-config/fastfetch.json);
  };

  programs.neovim = {
    enable = true;
    extraLuaPackages = ps: [ps.magick];
  };
}
