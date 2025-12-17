{
  pkgs,
  config,
  inputs,
  stateVersion,
  home,
  ...
}:
{
  imports = [
    ./nvidia.nix
    inputs.niri-flake.nixosModules.niri
  ];

  boot.loader.limine.style = {
    wallpapers = [ config.home-manager.users.devin.stylix.image ];
    wallpaperStyle = "centered";
    backdrop = "010101";
  };

  services.displayManager.ly = {
    x11Support = false;
    enable = true;
    settings = {
      asterisk = 8226;
      bigclock = "en";
      bigclock_12hr = true;
      brightness_down_key = null;
      brightness_up_key = null;
      clear_password = true;
      default_input = "password";
      animation = "colormix";
      colormix_col2 = "0xFF0000";
      colormix_col1 = "0x0000FF";
    };
  };
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.devin = {
    isNormalUser = true;
    description = "Devin Droddy";
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
      "libvirtd"
    ];
    shell = pkgs.nushell;
  };

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit stateVersion;
      inherit home;
    };
    users = {
      "devin" = ./home.nix;
    };
  };

  hardware.bluetooth.enable = true;

  hardware.xpadneo.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    monaspace
  ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "devin" ];
  };
  environment.etc."1password/custom_allowed_browsers" = {
    text = ''
      zen
    '';
    mode = "0755";
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [ ];

  services.flatpak.enable = true;

  security.sudo.extraConfig = "Defaults pwfeedback";

  services.gnome.gnome-keyring.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  environment.sessionVariables = {
    EDITOR = "nvim";
    PROTON_ENABLE_WAYLAND = 1;
    # DOTNET_ROOT = "${pkgs.dotnet-sdk_6}/share/dotnet";
    XKB_DEFAULT_LAYOUT = "us(colemak_dh)";
  };

  programs.steam.enable = true;

  qt.enable = true;

  services.libinput.mouse.accelProfile = "flat";

  virtualisation.docker.enable = true;
  services.playerctld.enable = true;

  nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];

  services.cloudflare-warp.enable = true;

  networking.hosts = {
    "192.168.86.48" = [ "electron.lan" ];
    "192.168.86.41" = [ "tau.lan" ];
    "192.168.86.34" = [ "photon.lan" ];
    "192.168.86.39" = [ "down.lan" ];
  };
}
