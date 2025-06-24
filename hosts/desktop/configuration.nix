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

  # services.open-webui.enable = true;
}
