{
  pkgs,
  lib,
  inputs,
  stateVersion,
  graphical,
  isDarwin,
  darwinStateVersion,
  ...
}:
{
  imports =
    (lib.optional (!isDarwin) inputs.sops.nixosModules.sops) ++ (lib.optional graphical ./graphical);

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
  system.stateVersion = if isDarwin then darwinStateVersion else stateVersion; # Did you read the comment?

  time.timeZone = "America/New_York";

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
      inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.nixvim
      jujutsu
      git
      sops
    ];

  services.openssh.enable = !graphical;
}
// lib.optionalAttrs (!isDarwin) {
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

  networking.networkmanager.enable = true;

  sops.age.keyFile =
    let
      user = if graphical then "devin" else "admin";
    in
    "/home/${user}/.config/sops/age/keys.txt";
}
// lib.optionalAttrs isDarwin {
  nixpkgs.hostPlatform = "aarch64-darwin";
}
