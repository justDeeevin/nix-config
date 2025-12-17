{ inputs, config, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;

    colors =
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

    settings =
      let
        widgetsFn = widget: if builtins.isAttrs widget then widget else { id = widget; };
        widgets = list: builtins.map widgetsFn list;
      in
      {
        bar = {
          outerCorners = false;
          widgets = {
            left = widgets [
              {
                id = "Tray";
                drawerEnabled = false;
              }
              "Workspace"
              "ActiveWindow"
            ];
            center = [
              {
                id = "Clock";
                formatHorizontal = "h:mm a ddd, MMM dd";
              }
            ];
            right = widgets [
              "plugin:privacy-indicator"
              {
                id = "MediaMini";
                showAlbumArt = true;
              }
              "Battery"
              {
                id = "NotificationHistory";
                showUnreadBadge = false;
              }
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
            ];
          };
        };
        general = {
          avatarImage = ./devin.jpg;
          lockOnSuspend = false; # handled by swayidle
          enableShadows = false;
        };
        ui = rec {
          fontDefault = "Monaspace Neon";
          fontFixed = fontDefault;
        };
        location = {
          weatherEnabled = false;
          use12hourFormat = true;
        };
        wallpaper = {
          fillColor = "#010101";
          fillMode = "center";
        };
        controlCenter = {
          shortcuts = {
            left = widgets [
              "WiFi"
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
        dock.enabled = false;
        sessionMenu.powerOptions =
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
              enabled = true;
              command = "loginctl lock-session";
            }
            "logout"
            "suspend"
            "reboot"
            "shutdown"
          ];
      };
  };

  xdg.configFile."noctalia/plugins.json".text = builtins.toJSON {
    sources = [
      {
        enabled = true;
        name = "Official Noctalia Plugins";
        url = "https://github.com/noctalia-dev/noctalia-plugins";
      }
    ];
    states.privacy-indicator.enabled = true;
    version = 1;
  };

  xdg.configFile."noctalia/plugins/privacy-indicator/settings.json".text = builtins.toJSON {
    hideInactive = true;
    iconSpacing = 4;
    removeMargins = false;
  };

  xdg.cacheFile."noctalia/wallpapers.json".text = builtins.toJSON {
    defaultWallpaper = ./scp_3001_by_sunnyclockwork.jpg;
  };
}
