{
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${lib.getExe pkgs.networkmanagerapplet}"
    ];

    bind = [
      ", xf86monbrightnessup, exec, ${lib.getExe pkgs.brightnessctl} set 10%+"
      ", xf86monbrightnessdown, exec, ${lib.getExe pkgs.brightnessctl} set 10%-"
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

  services.hypridle = {
    enable = true;
    settings.general = {
      lock_cmd = "swaylock";
      before_sleep_cmd = "loginctl lock-session";
    };
  };
}
