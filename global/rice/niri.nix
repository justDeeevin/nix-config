{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.niri.settings = {
    prefer-no-csd = true;
    spawn-at-startup = [
      {
        argv = [
          (lib.getExe pkgs.swayidle)
          "-w"
          "lock"
          "hyprlock"
          "before-sleep"
          "loginctl lock-session"
        ];
      }
    ];
    input = {
      focus-follows-mouse.enable = true;
      keyboard = {
        numlock = true;
        xkb = {
          layout = "us";
          variant = "colemak_dh";
          options = "compose:ralt";
        };
      };
      mouse.accel-profile = "flat";
      touchpad.accel-profile = "flat";
      warp-mouse-to-focus.enable = true;
    };
    outputs.DP-1 = {
      backdrop-color = "010101";
      variable-refresh-rate = true;
    };
    cursor.size = 32;
    layout = {
      default-column-width.proportion = 0.5;
      focus-ring.width = 2;
      gaps = 10;
      preset-column-widths = [
        { proportion = 1. / 3.; }
        { proportion = 0.5; }
        { proportion = 2. / 3.; }
      ];
    };
    environment = {
      # NVIDIA stuff
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";

      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
    binds =
      with config.lib.niri.actions;
      let
        playerctl = lib.getExe pkgs.playerctl;
      in
      builtins.mapAttrs (name: value: if value ? repeat then value else value // { repeat = false; }) {
        "Mod+Slash".action = show-hotkey-overlay;

        "Mod+T".action = spawn (lib.getExe pkgs.ghostty);
        "Mod+Q".action = close-window;

        "Mod+W".action = switch-preset-column-width;
        "Mod+F".action = maximize-column;
        "Mod+O".action = toggle-overview;

        "Mod+S".action = set-dynamic-cast-window;
        "Mod+Shift+S".action = set-dynamic-cast-monitor;
        "Ctrl+Mod+S".action = clear-dynamic-cast-target;

        "Mod+M".action = focus-column-left;
        "Mod+Left".action = focus-column-left;
        "Mod+Shift+M".action = swap-window-left;
        "Mod+Shift+Left".action = swap-window-left;

        "Mod+N".action = focus-workspace-down;
        "Mod+Down".action = focus-workspace-down;
        "Mod+Shift+N".action = move-window-to-workspace-down;
        "Mod+Shift+Down".action = move-window-to-workspace-down;

        "Mod+E".action = focus-workspace-up;
        "Mod+Up".action = focus-workspace-up;
        "Mod+Shift+E".action = move-window-to-workspace-up;
        "Mod+Shift+Up".action = move-window-to-workspace-up;

        "Mod+I".action = focus-column-right;
        "Mod+Right".action = focus-column-right;
        "Mod+Shift+I".action = swap-window-right;
        "Mod+Shift+Right".action = swap-window-right;

        "Ctrl+Mod+N".action = move-workspace-down;
        "Ctrl+Mod+E".action = move-workspace-up;

        "F10".action = toggle-window-floating;
        "Mod+F11".action = fullscreen-window;

        "XF86Calculator".action = spawn (lib.getExe pkgs.kdePackages.kalk);
        "XF86Mail".action = spawn (lib.getExe pkgs.ghostty);

        "Mod+Space".action = spawn "vicinae" "open";
        "Print".action.screenshot.show-pointer = false;
        "Ctrl+Shift+Space".action = spawn (lib.getExe pkgs._1password-gui) "--quick-access";
        "Ctrl+Shift+Backslash".action = spawn (lib.getExe pkgs._1password-gui);
        "Mod+C".action = spawn (lib.getExe pkgs.hyprpicker) "-a";
        "Mod+v".action = spawn "vicinae" "vicinae://extensions/vicinae/clipboard/history";
        "Mod+Period".action = spawn "vicinae" "vicinae://extensions/vicinae/vicinae/search-emojis";

        "XF86AudioRaiseVolume" = {
          action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+";
          repeat = true;
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
          repeat = true;
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
          allow-when-locked = true;
        };
        "XF86AudioPlay" = {
          action = spawn playerctl "play-pause";
          allow-when-locked = true;
        };
        "XF86AudioNext" = {
          action = spawn playerctl "next";
          allow-when-locked = true;
        };
        "XF86AudioPrev" = {
          action = spawn playerctl "previous";
          allow-when-locked = true;
        };
      };
    gestures = {
      hot-corners.enable = false;
    };
    window-rules = [
      {
        matches = [ { is-window-cast-target = true; } ];
        focus-ring =
          let
            colors = (config.stylix.base16.mkSchemeAttrs config.stylix.base16Scheme).withHashtag;
          in
          {
            active.color = colors.green;
            urgent.color = colors.base0F;
          };
      }
      {
        matches = [ { app-id = "com.mitchellh.ghostty"; } ];
        draw-border-with-background = false;
      }
      {
        matches = [ { app-id = "1password"; } ];
        block-out-from = "screencast";
      }
      {
        matches = [
          {
            app-id = "steam";
            title = "^notificationtoasts";
          }
        ];
        open-focused = false;
        default-floating-position = {
          x = 0;
          y = 0;
          relative-to = "bottom-right";
        };
      }
    ];
    debug.honor-xdg-activation-with-invalid-serial = [ ];
    xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite-unstable;
  };
}
