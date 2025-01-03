{
  pkgs,
  lib,
  ...
}: {
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./styles/waybar.css;
    settings.topBar = {
      layer = "top";
      position = "top";
      modules-left = ["tray" "hyprland/workspaces" "hyprland/window"];
      modules-center = ["clock"];
      modules-right = ["mpris" "pulseaudio" "custom/swaync" "privacy" "custom/power"];
      spacing = 5;

      "hyprland/workspaces" = {
        format = "{icon}|{windows}";
        format-icons = {
          special = "🫥";
        };
        window-rewrite-default = "";
        show-special = true;
        window-rewrite = {
          "class<zen-beta>" = "󰈹";
          "class<com.mitchellh.ghostty>" = "";
          "class<YouTube Music>" = "";
          "class<vesktop>" = "";
          "class<steam>" = "";
        };
      };

      clock = {
        format = "{:%I:%M %p}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar.format = {
          months = "<b>{}</b>";
          weeks = "<b>{}</b>";
          weekdays = "<b>{}</b>";
          days = "<b>{}</b>";
          today = ''<span color="#ff7eb6"><b>{}</b></span>'';
        };
      };

      mpris = {
        interval = 1;
        format = "{player_icon} {status_icon} {dynamic}";
        tooltip = false;
        player-icons = {
          chromium = "";
          firefox = "󰈹";
        };
        status-icons = {
          playing = "";
          paused = "";
          stopped = "";
        };
        dynamic-order = ["title" "artist"];
        title-len = 20;
      };

      "custom/power" = {
        format = "";
        on-click = "syspower";
        tooltip = false;
      };

      battery.interval = 5;

      pulseaudio = {
        on-click = "${lib.getExe pkgs.bun} ${./scripts/audio-sink.ts}";
        on-click-right = "wpctl set-mute @DEFAULT_SINK@ toggle";
        format = "{volume}%  {desc}";
        format-muted = "{volume}%  {desc}";
        tooltip = false;
        max-length = 30;
      };

      "custom/swaync" = {
        tooltip = false;
        format = "{} {icon}";
        "format-icons" = {
          notification = "󱅫";
          none = "";
          "dnd-notification" = " ";
          "dnd-none" = "󰂛";
          "inhibited-notification" = " ";
          "inhibited-none" = "";
          "dnd-inhibited-notification" = " ";
          "dnd-inhibited-none" = " ";
        };
        "return-type" = "json";
        "exec-if" = "which swaync-client";
        exec = "swaync-client -swb";
        "on-click" = "swaync-client -t";
        "on-click-right" = "swaync-client -d";
        escape = true;
      };
    };
  };
}
