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
  imports = [ ./hardware-configuration.nix ];

  programs.adb.enable = true;

  programs.alvr.enable = true;
  programs.alvr.openFirewall = true;

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  services.hardware.openrgb.enable = true;

  services.udev.packages = [
    pkgs.qmk-udev-rules
    probe-rs-udev-rules
  ];

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Canon";
        location = "Helen's Office";
        deviceUri = "dnssd://Canon%20MF642C%2F643C%2F644C%20(e3%3Aac%3A28)%20(e3%3Aac%3A28)%20(5%20%20(e3%3Aac%3A28)%20(2)._ipp._tcp.local/?uuid=6d4ff0ce-6b11-11d8-8020-f4a997d1e389";
        model = "everywhere";
      }
    ];
    ensureDefaultPrinter = "Canon";
  };

  hardware.openrazer = {
    enable = true;
    users = [ "devin" ];
  };

  boot.loader.limine = {
    # TODO: enroll keys on laptop
    secureBoot.enable = true;
    extraEntries = ''
      /Windows
        protocol: efi
        path: uuid(7b29883e-b185-45c3-96dd-9c9b4f3b85c4):/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };

}
