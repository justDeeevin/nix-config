{
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${lib.getExe pkgs.networkmanagerapplet}"
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

  programs.hyprlock = {
    enable = true;
  };

  services.hypridle = {
    enable = true;
    settings.general = {
      lock_cmd = "hyprlock";
      before_sleep_cmd = "loginctl lock-session";
    };
  };
}
