{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  programs.adb.enable = true;

  programs.alvr.enable = true;
  programs.alvr.openFirewall = true;

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  services.hardware.openrgb.enable = true;

  services.udev.packages = [ pkgs.qmk-udev-rules ];

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
}
