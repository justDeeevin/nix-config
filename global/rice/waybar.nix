{
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./styles/waybar.css;
    settings.topBar = {
      layer = "top";
      position = "top";
      modules-left = ["tray" "hyprland/workspaces" "hyprland/window"];
      modules-center = ["clock"];
      modules-right = ["mpris" "pulseaudio" "custom/power"];
      spacing = 5;

      "hyprland/workspaces" = {
        format = "{icon} - {windows}";
        window-rewrite-default = "";
        window-rewrite = {
          "class<zen-alpha>" = "󰈹";
          "class<org.wezfurlong.wezterm>" = "";
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
        title-len = 30;
      };

      "custom/power" = {
        format = "";
        on-click = "nu ${./scripts/power-list.nu}";
        tooltip = false;
      };

      battery.interval = 5;

      pulseaudio = {
        on-click = "nu ${./scripts/audio-sink.nu} tofi";
        format = "{volume}%  {desc}";
        format-muted = "{volume}%  {desc}";
        tooltip = false;
      };
    };
  };
}
