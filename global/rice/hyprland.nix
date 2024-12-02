{
  pkgs,
  lib,
  ...
}: let
  playerctl = "${pkgs.playerctl}/bin/playerctl";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      cursor.no_hardware_cursors = true;
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];

      general.gaps_out = "0,20,20,20";

      "$mod" = "SUPER";

      bind = [
        "$mod, T, exec, wezterm"
        "$mod, Q, killactive"
        "$mod, D, exit"

        "$mod, M, movefocus, l"
        "$mod SHIFT, M, swapwindow, l"
        "$mod, N, movefocus, d"
        "$mod SHIFT, N, swapwindow, d"
        "$mod, E, movefocus, u"
        "$mod SHIFT, E, swapwindow, u"
        "$mod, I, movefocus, r"
        "$mod SHIFT, I, swapwindow, r"

        "$mod ALT, M, workspace, -1"
        "$mod ALT SHIFT, M, movetoworkspace, -1"
        "$mod ALT, I, workspace, +1"
        "$mod ALT SHIFT, I, movetoworkspace, +1"
        "$mod, KP_End, workspace, 1"
        "$mod SHIFT, KP_End, movetoworkspace, 1"
        "$mod, KP_Down, workspace, 2"
        "$mod SHIFT, KP_Down, movetoworkspace, 2"
        "$mod, KP_Next, workspace, 3"
        "$mod SHIFT, KP_Next, movetoworkspace, 3"
        "$mod, KP_Left, workspace, 4"
        "$mod SHIFT, KP_Left, movetoworkspace, 4"
        "$mod, KP_Begin, workspace, 5"
        "$mod SHIFT, KP_Begin, movetoworkspace, 5"
        "$mod, KP_Right, workspace, 6"
        "$mod SHIFT, KP_Right, movetoworkspace, 6"
        "$mod, KP_Home, workspace, 7"
        "$mod SHIFT, KP_Home, movetoworkspace, 7"
        "$mod, KP_Up, workspace, 8"
        "$mod SHIFT, KP_Up, movetoworkspace, 8"
        "$mod, KP_Prior, workspace, 9"
        "$mod SHIFT, KP_Prior, movetoworkspace, 9"
        "$mod, KP_Insert, workspace, 10"
        "$mod SHIFT, KP_Insert, movetoworkspace, 10"
        "$mod, KP_Enter, togglespecialworkspace"
        "$mod SHIFT, KP_Enter, movetoworkspace, special"

        ", F11, fullscreen"

        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", Xf86AudioPlay, exec, ${playerctl} play-pause"
        ", Xf86AudioNext, exec, ${playerctl} next"
        ", Xf86AudioPrev, exec, ${playerctl} previous"

        "$mod, SPACE, exec, tofi-drun | xargs hyprctl dispatch exec --"
        "$mod, P, exec, nu ${./scripts/power-list.nu}"
        ", Print, exec, ${lib.getExe pkgs.grimblast} copy area"

        "CTRL SHIFT, SPACE, exec, 1password --quick-access"
        "CTRL SHIFT, BACKSLASH, exec, 1password"
        "$mod, C, exec, ${lib.getExe pkgs.hyprpicker} -a"
      ];

      bindm = "$mod, mouse:272, movewindow";

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "suppressevent fullscreen, class:.*"
      ];

      exec-once = [
        "zen"
        "waybar"
        "wezterm"
        "${pkgs.playerctl}/bin/playerctld"
        "${pkgs.swaybg}/bin/swaybg -i ${./scp_3001_by_sunnyclockwork.jpg} -m center --color 010101"
        "${lib.getExe pkgs.swaynotificationcenter}"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "colemak_dh";
      };
    };
  };
}
