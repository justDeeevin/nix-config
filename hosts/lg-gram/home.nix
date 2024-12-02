{
  pkgs,
  lib,
  ...
}: {
  imports = [./plasma.nix];
  wayland.windowManager.hyprland.settings.exec-once = [
    "${lib.getExe pkgs.networkmanagerapplet}"
  ];
}
