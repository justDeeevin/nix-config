{
  inputs,
  pkgs,
  lib,
  stateVersion,
  graphical,
  ...
}:
{
  imports = [
    inputs.sops.nixosModules.sops
  ]
  ++ lib.optional graphical ./graphical;

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
      "adbusers"
      "libvirtd"
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.nushell;
  };

  system.stateVersion = stateVersion;

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

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

  i18n.inputMethod = {
    enable = true;
    type = "ibus";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "colemak_dh";
  };
  console.useXkbConfig = true;

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

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
      inputs.self.packages.${stdenv.hostPlatform.system}.nixvim
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
    config.font-name = "Monaspace Krypton";
  };

  services.earlyoom.enable = true;
}
