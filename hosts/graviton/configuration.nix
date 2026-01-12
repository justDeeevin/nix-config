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
in
{
  imports = [
    ./hardware-configuration.nix
    # ./arr.nix
  ];

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  services.hardware.openrgb.enable = true;

  services.udev.packages = [
    pkgs.qmk-udev-rules
    probe-rs-udev-rules
  ];

  hardware.openrazer = {
    enable = true;
    users = [ "devin" ];
  };

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
}
