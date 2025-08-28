{ pkgs, lib, ... }:
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      ", xf86monbrightnessup, exec, ${lib.getExe pkgs.brightnessctl} set 10%+"
      ", xf86monbrightnessdown, exec, ${lib.getExe pkgs.brightnessctl} set 10%-"
      "$mod, L, exec, loginctl lock-session"
    ];

    monitor = ",preferred,auto,1.333333";

    input.touchpad = {
      natural_scroll = true;
      scroll_factor = 0.65;
      clickfinger_behavior = true;
    };

    gestures = {
      workspace_swipe = true;
    };
  };

}
