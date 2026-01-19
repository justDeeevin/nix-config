{
  pkgs,
  lib,
  inputs,
  stateVersion,
  graphical,
  ...
}:
{
  imports = [
    inputs.sops.nixosModules.sops
  ]
  ++ lib.optional graphical ./graphical;

  # Bootloader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
  }
  // (
    if graphical then
      { limine.enable = true; }
    else
      {
        grub = {
          enable = true;
          device = "/dev/sda";
        };
      }
  );
  boot.supportedFilesystems = [ "ntfs" ];

  users.users.admin = lib.mkIf (!graphical) {
    isNormalUser = true;
    description = "Administrator";
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
      "libvirtd"
    ];
    shell = pkgs.nushell;
  };

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

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    # permittedInsecurePackages = [ "dotnet-sdk-6.0.428" ];
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
      "https://cache.nixos-cuda.org/"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [ (if graphical then "devin" else "admin") ];
  };

  environment.systemPackages =
    with pkgs;
    lib.optionals (!graphical) [
      inputs.self.packages.x86_64-linux.nixvim
      jujutsu
      git
      sops
    ];

  services.openssh.enable = !graphical;

  sops.age.keyFile =
    let
      user = if graphical then "devin" else "admin";
    in
    "/home/${user}/.config/sops/age/keys.txt";

  services.kmscon = {
    enable = true;
    useXkbConfig = true;
    fonts = [
      {
        name = "Monaspace Krypton";
        package = pkgs.monaspace;
      }
    ];
  };
}
