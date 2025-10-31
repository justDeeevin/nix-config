{ pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;

    plugins = with pkgs.hyprlandPlugins; [
      hypr-dynamic-cursors
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
        # NVIDIA stuff
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"

        "XCURSOR_SIZE,32"
        "ELECTRON_OZONE_PLATFORM_HINT,wayland"
      ];

      general.gaps_out = "0,20,20,20";

      "$mod" = "SUPER";

      bind = [
        "$mod, T, exec, ghostty"
        "$mod, Q, killactive"

        "$mod, M, movefocus, l"
        "$mod, LEFT, movefocus, l"
        "$mod SHIFT, M, swapwindow, l"
        "$mod SHIFT, LEFT, swapwindow, l"
        "$mod, N, movefocus, d"
        "$mod, DOWN, movefocus, d"
        "$mod SHIFT, N, swapwindow, d"
        "$mod SHIFT, DOWN, swapwindow, d"
        "$mod, E, movefocus, u"
        "$mod, UP, movefocus, u"
        "$mod SHIFT, E, swapwindow, u"
        "$mod SHIFT, UP, swapwindow, u"
        "$mod, I, movefocus, r"
        "$mod, RIGHT, movefocus, r"
        "$mod SHIFT, I, swapwindow, r"
        "$mod SHIFT, RIGHT, swapwindow, r"

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

        ", F10, togglefloating"
        "$mod, F11, fullscreen"

        ", XF86Calculator, exec, kalk"
        ", XF86Mail, exec, ghostty"

        "$mod, SPACE, exec, vicinae open"
        ", Print, exec, ${lib.getExe pkgs.grimblast} copy area"
        "CTRL SHIFT, SPACE, exec, 1password --quick-access"
        "CTRL SHIFT, BACKSLASH, exec, 1password"
        "$mod, C, exec, ${lib.getExe pkgs.hyprpicker} -a"
        "$mod, v, exec, vicinae vicinae://extensions/vicinae/clipboard/history"
        "$mod, PERIOD, exec, vicinae vicinae://extensions/vicinae/vicinae/search-emojis"
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      bindi =
        let
          playerctl = lib.getExe pkgs.playerctl;
        in
        [
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", Xf86AudioPlay, exec, ${playerctl} play-pause"
          ", Xf86AudioNext, exec, ${playerctl} next"
          ", Xf86AudioPrev, exec, ${playerctl} previous"
        ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      exec-once = [
        "${pkgs.playerctl}/bin/playerctld"
        "${lib.getExe pkgs.swaybg} -i ${./scp_3001_by_sunnyclockwork.jpg} -m center --color 010101"
        "systemctl --user start hyprpolkitagent"
        (lib.getExe pkgs.syshud)
      ];

      input = {
        kb_layout = "us";
        kb_variant = "colemak_dh";
        numlock_by_default = true;
        kb_options = "compose:ralt";
      };

      misc.focus_on_activate = true;
      debug.full_cm_proto = true;
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
