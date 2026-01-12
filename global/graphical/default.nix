{
  pkgs,
  lib,
  config,
  inputs,
  stateVersion,
  home,
  isDarwin,
  ...
}:
{
  users.users.devin = {
    description = "Devin Droddy";
    shell = pkgs.nushell;
    home = if isDarwin then "/Users/devin" else "/home/devin";
  };
  environment.shells = [ pkgs.nushell ];

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit
        inputs
        stateVersion
        home
        isDarwin
        ;
    };
    users = {
      "devin" = ./home.nix;
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    monaspace
  ];

  programs._1password.enable = true;
  programs._1password-gui.enable = true;

  security.sudo.extraConfig = "Defaults pwfeedback";

  nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];
}
// lib.optionalAttrs (!isDarwin) {
  imports = [
    ./nvidia.nix
    inputs.niri-flake.nixosModules.niri
  ];

  boot.loader.limine.style = {
    wallpapers = [ config.home-manager.users.devin.stylix.image ];
    wallpaperStyle = "centered";
    backdrop = "010101";
  };

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  hardware.bluetooth.enable = true;

  hardware.xpadneo.enable = true;

  services.flatpak.enable = true;

  services.gnome.gnome-keyring.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  programs.steam.enable = true;

  qt.enable = true;

  services.libinput.mouse.accelProfile = "flat";

  virtualisation.docker.enable = true;
  services.playerctld.enable = true;

  services.cloudflare-warp.enable = true;

  xdg.portal = {
    extraPortals =
      with pkgs;
      lib.mkForce [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        gnome-keyring
      ];

    config.niri = {
      default = [
        "gnome"
        "gtk"
      ];
      "org.freedesktop.impl.portal.Access" = "gtk";
      "org.freedesktop.impl.portal.Notification" = "gtk";
      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
    };
  };

  networking.hosts = {
    "192.168.86.48" = [ "electron.lan" ];
    "192.168.86.41" = [ "tau.lan" ];
    "192.168.86.34" = [ "photon.lan" ];
    "192.168.86.39" = [ "down.lan" ];
    "192.168.86.40" = [ "charm.lan" ];
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
    PROTON_ENABLE_WAYLAND = 1;
    # DOTNET_ROOT = "${pkgs.dotnet-sdk_6}/share/dotnet";
    XKB_DEFAULT_LAYOUT = "us(colemak_dh)";
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [ ];
  programs._1password-gui.polkitPolicyOwners = [ "devin" ];
  users.users.devin = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
      "libvirtd"
    ];
  };

  environment.etc."1password/custom_allowed_browsers" = {
    text = ''
      zen
    '';
    mode = "0755";
  };
}
