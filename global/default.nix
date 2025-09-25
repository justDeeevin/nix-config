{
  pkgs,
  inputs,
  stateVersion,
  home,
  ...
}:
{
  imports = [
    ./nvidia.nix
    inputs.sops.nixosModules.sops
  ];

  # Bootloader.
  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = stateVersion; # Did you read the comment?

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # services.desktopManager.plasma6.enable = true;
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  programs.hyprland.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak_dh";
  };
  console.useXkbConfig = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

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

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    # permittedInsecurePackages = [ "dotnet-sdk-6.0.428" ];
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org/"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
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

  sops.age.keyFile = "/home/devin/.config/sops/age/keys.txt";

  programs.steam.enable = true;

  qt.enable = true;

  services.libinput.mouse.accelProfile = "flat";
  services.logind.settings.Login.HandlePowerKey = "suspend";

  virtualisation.docker.enable = true;
}
