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

  services.hypridle = {
    enable = true;
    settings.general = {
      lock_cmd = "hyprlock";
      before_sleep_cmd = "loginctl lock-session";
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };

      background = lib.mkForce {
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
      };

      label = [
        {
          text = "<b>$TIME12</b>";
          position = "0, 10%";
          halign = "center";
          font_size = 50;
          font_family = "Monaspace Neon";
        }
      ];
    };
  };
}
