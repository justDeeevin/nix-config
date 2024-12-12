{
  pkgs,
  lib,
  ...
}: let
  playerctl = "${pkgs.playerctl}/bin/playerctl";
in {
  wayland.windowManager.hyprland = {
    enable = true;

    plugins = with pkgs.hyprlandPlugins; [
      hypr-dynamic-cursors
      hyprspace
    ];

    settings = {
      decoration.rounding = 8;

      plugin = {
        dynamic-cursors = {
          enabled = true;
          shake.enabled = true;
          mode = "tilt";
          tilt.limit = 2000;
        };
      };

      cursor.no_hardware_cursors = true;
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "XCURSOR_SIZE,32"
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

        "$mod ALT, E, overview:toggle"
        "$mod ALT, N, overview:close"

        ", F11, fullscreen"

        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", Xf86AudioPlay, exec, ${playerctl} play-pause"
        ", Xf86AudioNext, exec, ${playerctl} next"
        ", Xf86AudioPrev, exec, ${playerctl} previous"

        "$mod, SPACE, exec, fuzzel"
        "$mod, P, exec, syspower"
        ", Print, exec, ${lib.getExe pkgs.grimblast} copy area"

        "CTRL SHIFT, SPACE, exec, 1password --quick-access"
        "CTRL SHIFT, BACKSLASH, exec, 1password"
        "$mod, C, exec, ${lib.getExe pkgs.hyprpicker} -a"

        "$mod, v, exec, wezterm --config enable_tab_bar=false start --class clipse -- ${lib.getExe pkgs.clipse}"
        ''$mod, PERIOD, exec, nu ${./scripts/emoji-list.nu} ${lib.getExe pkgs.wtype}''
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      bindm = "$mod, mouse:272, movewindow";

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "suppressevent fullscreen, class:.*"

        "float, class:(clipse)"
        "size 622 652, class:(clipse)"
      ];

      exec-once = [
        "zen"
        "waybar"
        "wezterm"
        "${pkgs.playerctl}/bin/playerctld"
        "${lib.getExe pkgs.swaybg} -i ${./scp_3001_by_sunnyclockwork.jpg} -m center --color 010101"
        "systemctl --user start hyprpolkitagent"
        "${lib.getExe pkgs.clipse} -listen"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "colemak_dh";
        numlock_by_default = true;
      };
    };
  };
}
