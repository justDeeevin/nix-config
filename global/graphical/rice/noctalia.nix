{
  inputs,
  config,
  ...
}:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;

    customPalettes.oxocarbon =
      let
        colors = (config.stylix.base16.mkSchemeAttrs config.stylix.base16Scheme).withHashtag;
      in
      rec {
        mSurface = colors.base00;
        mOnSurface = colors.base06;
        mPrimary = colors.orange;
        mOnPrimary = mOnSurface;
        mSecondary = colors.blue;
        mOnSecondary = mOnSurface;
        mTertiary = colors.yellow;
        mOnTertiary = mOnSurface;
        mSurfaceVariant = colors.base01;
        mOnSurfaceVariant = mOnSurface;
        mOutline = colors.base03;
        mShadow = colors.base01;
        mError = colors.red;
        mOnError = mOnSurface;
      };

    settings = {
      bar.main = {
        start = [
          "tray"
          "workspaces"
          "active_window"
        ];
        center = [ "clock" ];
        end = [
          "media"
          "battery"
          "notifications"
          "control-center"
        ];
      };
      widget = {
        clock.format = "%l:%M %p %a, %b %d";
        battery.display_mode = "graphic";
        control-center.glyph = "";
      };
      shell = {
        avatar_path = ./devin.jpg;
        panel.shadow = false;
        font_family = "Monaspace Neon";
        time_format = "%l:%M";
        session.actions =
          let
            powerOptions =
              options:
              builtins.map (
                option:
                if builtins.isAttrs option then
                  option
                else
                  {
                    action = option;
                    enabled = true;
                  }
              ) options;
          in
          powerOptions [
            {
              action = "lock";
              command = "hyprlock";
            }
            "logout"
            "suspend"
            "reboot"
            "shutdown"
          ];
      };
      wallpaper = {
        default.path = ./scp_3001_by_sunnyclockwork.jpg;
        fill_color = "#010101";
        fill_mode = "center";
      };
      # TODO:
      /*
        controlCenter = {
          shortcuts = {
            left = widgets [
              "Network"
              "Bluetooth"
            ];
            right = [ ];
          };
          cards = builtins.map (card-id: (widgetsFn card-id) // { enabled = true; }) [
            "profile-card"
            "shortcuts-card"
            "audio-card"
            "media-sysmon-card"
          ];
        };
      */
    };
  };

  # No plugins for v5 yet
  /*
    xdg.configFile."noctalia/plugins.json".text = builtins.toJSON {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = myLib.mkEnableList [
        "privacy-indicator"
        "kaomoji-provider"
        "unicode-picker"
      ];
      version = 1;
    };

    xdg.configFile."noctalia/plugins/privacy-indicator/settings.json".text = builtins.toJSON {
      hideInactive = true;
      iconSpacing = 4;
      removeMargins = false;
    };
  */
}
