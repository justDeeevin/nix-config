{
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${lib.getExe pkgs.networkmanagerapplet}"
    ];

    input.touchpad = {
      natural_scroll = true;
      scroll_factor = 0.65;
    };
  };
}
