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
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];

      monitor = [
        # "DP-1, highres@highrr, "
        "HDMI-A-1, highres@highrr, 0x0, 1, transform, 3"
      ];

      "$mod" = "SUPER";

      bind = [
        "$mod, T, exec, wezterm"
        "$mod, Q, killactive"
        "$mod, D, exit"

        # Vim-like focus + window movement (mind you, this is Colemak-DH)
        "$mod, M, movefocus, l"
        "$mod SHIFT, M, swapwindow, l"
        "$mod, N, movefocus, d"
        "$mod SHIFT, N, swapwindow, d"
        "$mod, E, movefocus, u"
        "$mod SHIFT, E, swapwindow, u"
        "$mod, I, movefocus, r"
        "$mod SHIFT, I, swapwindow, r"

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

        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", Xf86AudioPlay, exec, ${playerctl} play-pause"
        ", Xf86AudioNext, exec, ${playerctl} next"
        ", Xf86AudioPrev, exec, ${playerctl} previous"

        "$mod, SPACE, exec, tofi-drun | xargs hyprctl dispatch exec --"
        "$mod, P, exec, nu ${./scripts/power-list.nu}"
        ", Print, exec, ${lib.getExe pkgs.grimblast} copy area"
      ];

      exec-once = [
        "zen"
        "waybar"
        "wezterm"
        "${pkgs.playerctl}/bin/playerctld"
        "${pkgs.swaybg}/bin/swaybg -i ${./scp_3001_by_sunnyclockwork.jpg} -m center --color 010101"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "colemak_dh";
      };
    };
  };
}
