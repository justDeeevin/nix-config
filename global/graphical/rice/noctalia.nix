{
  inputs,
  ...
}:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
    settings = rec {
      shell = {
        time_format = "%l:%M %P";
        date_format = "%a, %b %e";
        show_location = false;
        corner_radius_scale = 0;
        setup_wizard_enabled = false;
        polkit_agent = true;
        avatar_path = ./devin.jpg;
        session.actions = [
          {
            action = "lock";
            command = "hyprlock";
          }
          {
            action = "logout";
          }
          {
            action = "suspend";
          }
          {
            action = "reboot";
          }
          {
            action = "shutdown";
          }
        ];
      };

      lockscreen.enabled = false;

      bar.default = {
        radius = 0;
        margin_ends = 0;
        capsule_radius = 0;
        widget_spacing = 15;
        start = [
          "tray"
          "workspaces"
          "active_window"
        ];
        center = [ "clock" ];
        end = [
          "privacy"
          "battery"
          "notifications"
          "media"
          "control-center"
        ];
      };

      widget = {
        battery.display_mode = "graphic";
        control-center.custom_image = "~/Pictures/nixos-logo.png";
        privacy.hide_inactive = true;
        clock.format = "${shell.time_format} ${shell.date_format}";
      };

      wallpaper = {
        fill_mode = "center";
        fill_color = "#010101";
        default.path = ./scp_3001_by_sunnyclockwork.jpg;
      };

      weather.enabled = false;

      control_center = {
        hidden_tabs = [ "system" ];
        shortcuts = builtins.map (x: { type = x; }) [
          "wifi"
          "bluetooth"
        ];
      };

      theme = {
        source = "community";
        custom_palette = "Oxocarbon";
      };
    };
  };
}
