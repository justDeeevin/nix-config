{pkgs, ...}: {
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
  home.packages = with pkgs.nix-stable; [
    firefox
    xdg-desktop-portal-gnome
    xdg-desktop-portal
    gnome.gnome-tweaks
    _1password-gui
    kitty
    alejandra
    lazygit
    bat
    pkgs.vesktop
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
    # unstable used because stable electron is insecure on unstable nixos
    pkgs.youtube-music
    pkgs.neovim-nightly
    wl-clipboard
    mangohud
    just
    ripgrep
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
  home.sessionVariables = {
    HELLO = "hi";
  };

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
}
