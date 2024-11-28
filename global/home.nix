{
  pkgs,
  inputs,
  stateVersion,
  home,
  ...
}: {
  imports = [
    home
    inputs.posting.modules.homeManager.default
    inputs.nix-index-database.hmModules.nix-index
    ./rice
  ];

  nixpkgs.config.allowUnfree = true;

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
    youtube-music
    wl-clipboard
    just
    vlc
    ffmpeg-full
    kdePackages.kalk
    jdk
    gradle
    zoom-us
    prismlauncher
    wineWowPackages.waylandFull
    unzip
    tree-sitter
    magic-wormhole
    btop
    libreoffice
    inputs.nixvim.packages.x86_64-linux.default
    inputs.zen-browser.packages.x86_64-linux.default
    obsidian
    chromium
    quickemu
    kdenlive
    mattermost-desktop
    nh

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
    "Pictures/nixos-logo.png" = {
      source = pkgs.fetchurl {
        url = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/Nix_snowflake.svg/1200px-Nix_snowflake.svg.png";
        hash = "sha256-1LolYJ2W+4SxCXC0O0430nKCbAcsUyaCksRPc3xYWZ0=";
      };
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
        c = "job:clippy";
      };
      default_job = "clippy";
      jobs = {
        clippy = {
          command = ["cargo" "clippy" "--all-targets" "--color" "always"];
        };
      };
    };
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
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
      wlrobs
      obs-pipewire-audio-capture
    ];
  };

  programs.nushell = {
    enable = true;
    # extraConfig is placed before shellAliases
    extraConfig = let
      gitCompletions = builtins.readFile (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/nushell/nu_scripts/refs/heads/main/custom-completions/git/git-completions.nu";
        hash = "sha256-iz840LwqUhkFNHnzNGZFPSUtd9JbJQCEIiz+ogZz9bY=";
      });
      justCompletions = builtins.readFile (pkgs.fetchurl {
        url = "https://github.com/nushell/nu_scripts/raw/refs/heads/main/custom-completions/just/just-completions.nu";
        hash = "sha256-U8eQ6we+wy7aG6VacYKcyTXGEJYzwNs5UPvUyV9HCUo=";
      });
      nixCompletions = builtins.readFile (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/nushell/nu_scripts/refs/heads/main/custom-completions/nix/nix-completions.nu";
        hash = "sha256-sKyBJETVwlRBccEbQicoVg/7/hDV9hrT9jT8hlwVWAs=";
      });
      cargoCompletions = builtins.readFile (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/nushell/nu_scripts/refs/heads/main/custom-completions/cargo/cargo-completions.nu";
        hash = "sha256-aGgoPgq4Zaj+eKu67fxnpTMm6lOvaaZ6j6cYxvWJ41M=";
      });
      batCompletions = builtins.readFile (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/nushell/nu_scripts/refs/heads/main/custom-completions/bat/bat-completions.nu";
        hash = "sha256-awl7UD1B8lgYeOZ9Rj9KK4arlpuX5Sx+SanlOM70ZRE=";
      });
      ghCompletions = builtins.readFile (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/nushell/nu_scripts/refs/heads/main/custom-completions/gh/gh-completions.nu";
        hash = "sha256-c2E+XAARdyLtZGhh7Stk6PjUwc77nJdC3q5OTIJjA60=";
      });
    in ''
      ${gitCompletions}

      ${justCompletions}

      ${nixCompletions}

      ${cargoCompletions}

      ${batCompletions}

      ${ghCompletions}

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

  programs.posting = {
    enable = true;
    settings = {
      animation = "full";
      theme = "oxocarbon";
    };
    themes = {
      oxocarbon = {
        # base08
        primary = "#3ddbd9";
        # base0F
        secondary = "#82cfff";
        # base0C
        accent = "#ff7eb6";
        # base00
        background = "#161616";
        # base02
        surface = "#393939";
        # base0A
        error = "#ee5396";
        # base0D
        success = "#42be65";
        # base0E
        warning = "#be95ff";
      };
    };
  };

  programs.nix-index-database.comma.enable = true;

  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}
