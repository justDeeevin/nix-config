{
  pkgs,
  inputs,
  stateVersion,
  home,
  lib,
  config,
  ...
}:
let
  nixvim = inputs.self.packages.x86_64-linux.nixvim.extend {
    plugins.obsidian = {
      enable = true;
      settings = {
        workspaces = [
          {
            name = "Third Brain";
            path = "~/Documents/Third Brain";
          }
        ];
        daily_notes = {
          folder = "Daily";
          template = "Templates/Daily Note Template.md";
          date_format = "%b %-d, %Y";
        };
        templates.subdir = "Templates";
        disable_frontmatter = true;
        attachments = {
          img_folder = "Assets";
          img_name_func.__raw = ''
            function()
              local date = os.date("*t")
              return string.format("Pasted image %d%d%d%d%d%d", date.year, date.month, date.day, date.hour, date.min, date.sec)
            end
          '';
          img_text_func.__raw = ''
            function(client, path)
              path = client:vault_relative_path(path) or path
              return string.format("![[%s]]", path.name)
            end
          '';
        };
      };
    };

    opts = {
      conceallevel = 2;
    };

    keymaps = [
      {
        key = "<leader>ot";
        action = "<cmd>ObsidianToday<CR>";
      }
      {
        key = "<leader>op";
        action = "<cmd>ObsidianPasteImg<CR>";
      }
    ];
  };
in
{
  imports = [
    home
    inputs.nix-index-database.hmModules.nix-index
    ./rice
    inputs.ags.homeManagerModules.default
    inputs.sops.homeManagerModules.sops
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "devin";
  home.homeDirectory = "/home/devin";

  home.stateVersion = stateVersion;

  home.sessionPath = [ "~/.bun/bin" ];

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
    prismlauncher
    wineWowPackages.waylandFull
    unzip
    tree-sitter
    magic-wormhole
    btop
    libreoffice
    inputs.zen-browser.packages.x86_64-linux.default
    obsidian
    chromium
    quickemu
    kdePackages.kdenlive
    nh
    hyprpolkitagent
    telegram-desktop
    hyprland-qtutils
    cargo-generate
    # godot
    typst
    sops
    timg
    r2modman
    (lib.hiPrio uutils-coreutils-noprefix)
    tldr
    gimp
    bluetui
    nixvim

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
    ".config/clipse/config.json".text = builtins.toJSON {
      imageDisplay = {
        type = "kitty";
        scaleX = 18;
        scaleY = 20;
      };
      keyBindings = {
        prevPage = "m";
        down = "n";
        up = "e";
        nextPage = "i";
      };
    };
    ".cargo/config.toml".source = pkgs.writers.writeTOML "config.toml" {
      build.rustc-wrapper = lib.getExe pkgs.sccache;
    };
  };

  home.sessionVariables.EDITOR = nixvim;

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
    signing = {
      format = "ssh";
      key = "/home/devin/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      pull = {
        rebase = true;
        default = "current";
      };
      push = {
        autoSetupRemote = true;
        default = "current";
        followTags = true;
      };
      core = {
        whitespace = "error";
      };
      rebase = {
        autoStash = true;
        missingCommitsCheck = "warn";
      };
    };
    delta.enable = true;
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
          command = [
            "cargo"
            "clippy"
            "--all-targets"
            "--color"
            "always"
          ];
        };
        build = {
          command = [
            "cargo"
            "build"
            "--color"
            "always"
          ];
        };
      };
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
      git.overrideGpg = true;
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
    extraConfig =
      let
        nu_scripts = pkgs.fetchFromGitHub {
          owner = "nushell";
          repo = "nu_scripts";
          rev = "5869e0b529affb59b1cf0fcc51d978a3ba993f0d";
          hash = "sha256-osLSKqfmiApgZdSNvNoenFZlFq3dwzwmoRv39WbMsp8=";
        };
        completions = "${nu_scripts}/custom-completions";
        getCompletions = cmd: "${completions}/${cmd}/${cmd}-completions.nu";
      in
      ''
        use ${getCompletions "git"}
        use ${getCompletions "just"}
        use ${getCompletions "nix"}
        use ${getCompletions "cargo"}
        use ${getCompletions "bat"}
        use ${getCompletions "gh"}

        $env.config.cursor_shape.emacs = "line"
        $env.config.show_banner = false

        def dev [path?: string] {
          nix develop ($path | default '.') --command nu
        }
      '';
    shellAliases = {
      cd = "z";
    };
    extraEnv = ''
      if not (try {$env.IN_NIX_SHELL; true} catch {false}) {
        # allows the window to get properly sized before the fastfetch image is rendered
        sleep 33ms
        fastfetch
      }

      $env.OPENAI_API_KEY = ^cat ${config.sops.secrets.OPENAI_API_KEY.path}
    '';
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.nix-index-database.comma.enable = true;

  programs.fuzzel = {
    enable = true;
    settings.colors = lib.mkForce rec {
      background = "161616ff";
      text = "ffffffff";
      match = "ee5396ff";
      selection-match = match;
      selection = "262626ff";
      selection-text = "33b1ffff";
      border = "525252ff";
    };
  };

  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Oxocarbon";

      font-family = "Monaspace Neon";
      font-feature = [
        "calt"
        "ss01"
        "ss02"
        "ss03"
        "ss04"
        "ss05"
        "ss07"
        "ss08"
        "ss09"
        "liga"
      ];

      window-decoration = false;

      mouse-hide-while-typing = true;

      background-opacity = 0.5;
      background-blur-radius = 20;

      auto-update = "off";
    };
  };

  programs.ags = {
    enable = true;

    configDir = ./ags;

    systemd.enable = true;

    extraPackages = with inputs.ags.packages.x86_64-linux; [
      notifd
      hyprland
      tray
      mpris
      apps
      wireplumber
      network
      battery
    ];
  };

  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
  };

  sops.age.keyFile = "/home/devin/.config/sops/age/keys.txt";
}
