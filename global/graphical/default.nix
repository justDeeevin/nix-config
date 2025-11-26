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

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
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
}
