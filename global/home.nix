{
  pkgs,
  inputs,
  stateVersion,
  home,
  lib,
  ...
}: {
  imports = lib.optionals (home != null) [home];

  nixpkgs.config.allowUnfree = true; # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "devin";
  home.homeDirectory = "/home/devin";

  home.stateVersion = stateVersion;

  home.sessionPath = [
    "~/.bun/bin"
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    bat
    vesktop
    gh
    clang
    youtube-music
    wl-clipboard
    just
    ripgrep
    python3
    vlc
    nodejs_20
    ffmpeg-full
    kdePackages.kalk
    jdk
    gradle
    zoom-us
    prismlauncher
    bun
    godot_4
    yt-dlp
    wineWowPackages.waylandFull
    unzip
    tree-sitter
    magic-wormhole
    btop
    kdePackages.kdenlive
    gzdoom
    libreoffice
    inputs.nixvim.packages.x86_64-linux.default
    inputs.zen-browser.packages.x86_64-linux.default
    obsidian
    chromium
    mindustry

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
      pull.rebase = true;
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
    enableNushellIntegration = true;
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
      default_job = "clippy";
      jobs = {
        clippy = {
          command = ["cargo" "clippy" "--all-targets" "--all-features" "--color" "always"];
        };
      };
    };
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  home.pointerCursor = let
    getFrom = url: hash: name: {
      gtk.enable = true;
      name = name;
      package = pkgs.runCommand "moveUp" {} ''
        mkdir -p $out/share/icons
        ln -s ${pkgs.fetchzip {
          url = url;
          hash = hash;
        }} $out/share/icons/${name}
      '';
    };
  in
    getFrom
    "https://cdn.discordapp.com/attachments/698251081569927191/1222751288941477978/posy-s-cursor.tar.xz?ex=66175ae0&is=6604e5e0&hm=6d2fdd7ce1c7b41cb56845093e2c0b9c7360cc8b29681d3da17c62c8ca162bc1&"
    "sha256-eeL9+3dcTX99xtUivfYt23R/jh8VIVqtMkoUPmk/12E="
    "Posy";

  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.monaspace;
      name = "Monaspace Neon";
    };
    settings = {
      enabled_layouts = "tall";
      font_features = "MonaspaceNeon-Regular +calt +ss01 +ss02 +ss03 +ss04 +ss05 +ss07 +ss08 +ss09 +liga";
      background = "#16181a";
      foreground = "#ffffff";
      cursor = "#ffffff";
      cursor_text_color = "#16181a";
      selection_background = "#3c4048";
      color0 = "#16181a";
      color8 = "#3c4048";
      color1 = "#ff6e5e";
      color9 = "#ff6e5e";
      color2 = "#5eff6c";
      color10 = "#5eff6c";
      color3 = "#f1ff5e";
      color11 = "#f1ff5e";
      color4 = "#5ea1ff";
      color12 = "#5ea1ff";
      color5 = "#bd5eff";
      color13 = "#bd5eff";
      color6 = "#5ef1ff";
      color14 = "#5ef1ff";
      color7 = "#ffffff";
      color15 = "#ffffff";
      selection_foreground = "#ffffff";
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
    settings = builtins.fromJSON (builtins.readFile ./fastfetch.json);
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
    ];
  };

  programs.nushell = {
    enable = true;
    # extraConfig is placed before shellAliases
    extraConfig = ''
      source ${./nu/git-completions.nu}
      $env.config.cursor_shape.emacs = "line"
      $env.config.show_banner = false
    '';
    shellAliases = {
      dev = "nix develop . --command nu";
      cd = "z";
    };
    extraEnv = ''
      fastfetch
    '';
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };
}
