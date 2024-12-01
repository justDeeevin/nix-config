{
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./styles/waybar.css;
    settings = {
      topBar = {
        layer = "top";
        position = "top";
        modules-left = ["tray" "hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = ["mpris" "custom/power"];
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
          tooltip-format = "{calendar}";
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
      };
    };
  };
}
