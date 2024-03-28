{
  pkgs,
  inputs,
  ...
}: {
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
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    firefox
    xdg-desktop-portal-gnome
    xdg-desktop-portal
    gnome.gnome-tweaks
    _1password-gui
    kitty
    alejandra
    lazygit
    bat
    vesktop
    fnm
    zoxide
    probe-rs
    pkg-config
    flip-link
    gh
    thefuck
    clang
    nix-index
    ntfs3g
    neofetch
    youtube-music
    neovim-nightly
    wl-clipboard
    mangohud
    just
    ripgrep
    cargo
    cargo-generate
    eww
    rofi-wayland
    playerctl
    dunst
    hyprpaper
    hyprpicker
    inputs.hyprswitch.packages.x86_64-linux.default

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
    ".config" = {
      source = ./.config;
      recursive = true;
    };

    "Pictures" = {
      source = ./Pictures;
      recursive = true;
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
    package = pkgs.nix-stable.git;
    enable = true;
    userName = "Devin Droddy";
    userEmail = "devin.droddy@gmail.com";
  };

  programs.nushell = {
    package = pkgs.nix-stable.nushell;
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
  };

  programs.starship = {
    package = pkgs.nix-stable.starship;
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
}
