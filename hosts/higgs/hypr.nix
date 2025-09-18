{ pkgs, lib, ... }:
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      ", xf86monbrightnessup, exec, ${lib.getExe pkgs.brightnessctl} set 10%+"
      ", xf86monbrightnessdown, exec, ${lib.getExe pkgs.brightnessctl} set 10%-"
      "$mod, L, exec, loginctl lock-session"
    ];

    monitor = ",preferred,auto,1";

    input.touchpad = {
      natural_scroll = true;
      scroll_factor = 0.65;
      clickfinger_behavior = true;
    };

    gesture =
      let
        playerctl = lib.getExe pkgs.playerctl;
      in
      [
        "3, horizontal, workspace"
        "4, left, dispatcher, exec, ${playerctl} previous"
        "4, down, dispatcher, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        "4, up, dispatcher, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        "4, right, dispatcher, exec, ${playerctl} next"
      ];
  };

  programs.hyprlock.settings.label = [
    {
      text = ''
        cmd[update:1000] echo "󰁹 $(cat /sys/class/power_supply/BAT0/capacity)%"
      '';
      position = "0, 6%";
      font_size = 35;
      font_family = "Monaspace neon";
      halign = "center";
    }
  ];
}
