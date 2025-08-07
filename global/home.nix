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
    inputs.nix-index-database.homeModules.nix-index
    ./rice
    inputs.sops.homeManagerModules.sops
  ];

  home.username = "devin";
  home.homeDirectory = "/home/devin";

  home.stateVersion = stateVersion;

  home.sessionPath = [ "~/.bun/bin" ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = pkgs.callPackage ./home-packages.nix { inherit inputs nixvim; };

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
    userEmail = "devin@justdeeevin.dev";
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

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Devin Droddy";
        email = "devin@justdeeevin.dev";
      };
      signing = {
        behavior = "own";
        backend = "ssh";
        key = "/home/devin/.ssh/id_ed25519.pub";
      };
      revsets.log = "all()";
      ui.default-command = "log";

      lazyjj.keybinds = {
        log_tab = {
          scroll-down = [
            "n"
            "down"
          ];
          scroll-down-half = "shift+n";
          scroll-up = [
            "e"
            "up"
          ];
          scroll-up-half = "shift+e";

          create-new = "ctrl+n";
          create-new-describe = "ctrl+shift+n";
          edit-change = "ctrl+e";
          edit-change-ignore-immutable = "ctrl+shift+e";
        };
      };
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "[┌<$all](bold green)$line_break$character";
      character = {
        success_symbol = "[└>](bold green)";
        error_symbol = "[└>](bold red)";
      };

      cmd_duration.min_time = 0;

      custom.jujutsu = {
        command = "prompt";
        format = "$output ";
        ignore_timeout = true;
        shell = [
          (lib.getExe inputs.starship-jj.packages.x86_64-linux.default)
          "--ignore-working-copy"
          "starship"
        ];
        use_stdin = false;
        detect_folders = [ ".jj" ];
      };

      git_branch.disabled = true;
      git_commit.disabled = true;
      git_state.disabled = true;
      git_metrics.disabled = true;
      git_status.disabled = true;
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
        c = "job:clippy";
      };
      default_job = "clippy";
      jobs = {
        clippy = {
          command = [
            "cargo"
            "clippy"
            "--all-targets"
            "--all-features"
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
          rev = "156a0110c724ce3a98327190e8a667657e4ed3c1";
          hash = "sha256-O/zqhTFzqhFwCD54iXDfe/9WlqMg2PkiO6TLwUyIxmM=";
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
        use ${getCompletions "ssh"}
        use ${getCompletions "typst"}
        use ${getCompletions "zoxide"}

        $env.config.cursor_shape.emacs = "line"
        $env.config.show_banner = false

        def dev [path?: string] {
          nix develop ($path | default '.') --command nu
        }

        def suspend [] {
          systemctl suspend
          exit
        }

        def "jj push" [] {
          jj bookmark m (git branch --show-current) --to @
          jj git push
        }
      '';
    shellAliases = {
      cd = "z";
      rm = "rip --graveyard ${config.home.homeDirectory}/.graveyard";
      shutdown = "shutdown now";
    };
    extraEnv = ''
      if not (try {$env.IN_NIX_SHELL; true} catch {false}) {
        # allows the window to get properly sized before the fastfetch image is rendered
        sleep 33ms
        fastfetch
      }

      $env.OPENAI_API_KEY = ^cat ${config.sops.secrets.OPENAI_API_KEY.path}
      $env.EDITOR = "${lib.getExe nixvim}"
    '';
  };

  programs.zoxide.enable = true;

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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  sops.age.keyFile = "/home/devin/.config/sops/age/keys.txt";

  programs.btop = {
    enable = true;
    themes.oxocarbon = pkgs.fetchurl {
      url = "https://gist.githubusercontent.com/gideonmt/cf8561cb130e3ca859f8a5471014e933/raw/c9e0f235c4148551f3dcf924d0a0abf6d76a1934/oxocarbon_dark.theme";
      hash = "sha256-D290uqP4GmM94nXYeoj2mRaXIPoQDoihe4CMeBBHRn0=";
    };
    settings = {
      color_theme = "oxocarbon";
      theme_background = false;
      update_ms = 100;
    };
  };

  programs.bat = {
    enable = true;
    themes.oxocarbon = {
      src = pkgs.fetchFromGitLab {
        owner = "boydkelly";
        repo = "carbonizer";
        rev = "09876beded0ff8b2769c86fc9940864e1c3224a5";
        hash = "sha256-4W6DeF1kAaAmfl5xFg5xBepgXndXKUaImpd3M6I53xk=";
      };
      file = "bat/oxocarbon-dark.tmTheme";
    };
    config.theme = "oxocarbon";
  };

  programs.ashell = {
    enable = true;
    systemd.enable = true;

    settings = {
      modules = {
        left = [
          "Tray"
          "Workspaces"
          "WindowTitle"
        ];
        center = [ "Clock" ];
        right = [
          "MediaPlayer"
          [
            "Privacy"
            "Settings"
          ]
        ];
      };
      workspaces.visibility_mode = "MonitorSpecific";
      appearance = {
        font_name = "Monaspace Neon";
      };
      clock.format = "%a %e %b %I:%M %p";
    };
  };

  services.swaync = {
    enable = true;
    settings = {
      notification-inline-replies = true;
    };
  };

  # one day 😢
  programs.qutebrowser = {
    # enable = true;
    keyBindings = {
      caret = {
        M = "scroll left";
        m = "move-to-prev-char";
        N = "scroll down";
        n = "move-to-next-line";
        E = "scroll up";
        e = "move-to-prev-line";
        I = "scroll right";
        i = "move-to-next-char";
      };

      normal = {
        M = "back";
        m = "scroll left";
        N = "tab-next";
        n = "scroll down";
        E = "tab-prev";
        e = "scroll up";
        I = "forward";
        i = "scroll right";

        u = "mode-enter insert";

        L = "undo -w";
        l = "undo";

        H = "bookmark-add";
        h = "quickmark-save";

        k = "search-next";
        K = "search-prev";
      };

      insert.en = "mode-leave";

    };
    extraConfig =
      # python
      ''
        c.url.searchengines = {
          'DEFAULT': 'https://google.com/search?hl=en&q={}',
          '!n': 'https://search.nixos.org/packages?channel=unstable&query={}',
          '!no': 'https://search.nixos.org/options?channel=unstable&query={}',
          '!hm': 'https://home-manager-options.extranix.com?release=master&query={}'
        }

        c.auto_save.session = True

        c.keyhint.blacklist = ['en']

        c.scrolling.smooth = True
        c.tabs.favicons.show = 'always'

        c.colors.webpage.darkmode.enabled
      '';
  };

  programs.gh = {
    enable = true;
    extensions = [
      inputs.gh-jj.packages.x86_64-linux.default
    ];
  };

  home.file.".XCompose".text = ''
    include "%L"
    <Multi_key> <e> <h> : "¯\\_(ツ)_/¯" # SHRUG
    <Multi_key> <o> <h> <m> : "Ω" # CAPITAL OMEGA
    <Multi_key> <p> <i> : "π" # PI
  '';
}
