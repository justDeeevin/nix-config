{ pkgs, ... }:
let
  probe-rs-udev-rules = pkgs.stdenv.mkDerivation {
    name = "probe-rs-udev-rules";

    src = pkgs.fetchurl {
      url = "https://probe.rs/files/69-probe-rs.rules";
      hash = "sha256-yjxld5ebm2jpfyzkw+vngBfHu5Nfh2ioLUKQQDY4KYo=";
    };

    phases = [ "installPhase" ];

    installPhase = ''
      install -D $src $out/lib/udev/rules.d/69-probe-rs.rules
    '';
  };
  steam-wire = pkgs.fetchFromGitHub {
    owner = "Widowan";
    repo = "steam-wire";
    rev = "e31ba1cd4053673a22df70bb65a85d866e9f5840";
    hash = "sha256-jbsngsVGIvm/m9FAq6CeXw47J7t2Q+RGg4ZFnXTtzdE=";
  };
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  environment.systemPackages = [ pkgs.gamescope-wsi ];

  services.hardware.openrgb.enable = true;

  services.udev.packages = [
    pkgs.qmk-udev-rules
    probe-rs-udev-rules
  ];

  boot.loader.limine = {
    secureBoot.enable = true;
    extraEntries = ''
      /Windows
        protocol: efi
        path: uuid(7b29883e-b185-45c3-96dd-9c9b4f3b85c4):/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };

  nixpkgs.config.cudaSupport = true;

  services.kmscon.hwRender = true;

  services.pipewire.wireplumber = {
    configPackages = [
      (pkgs.stdenv.mkDerivation {
        name = "90-steam-wire.conf";
        src = steam-wire;
        phases = [ "installPhase" ];
        installPhase = "install -D $src/90-steam-wire.conf $out/share/wireplumber/wireplumber.conf.d/90-steam-wire.conf";
      })
    ];

    extraScripts."steam-wire.lua" = builtins.readFile "${steam-wire}/steam-wire.lua";
  };
}
