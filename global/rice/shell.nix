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
        mPrimary = colors.blue;
        mOnPrimary = mOnSurface;
        mSecondary = colors.green;
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
              {
                id = "MediaMini";
                showAlbumArt = true;
              }
              "NotificationHistory"
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
            ];
          };
        };
        general = {
          avatarImage = ./devin.jpg;
          lockOnSuspend = false; # handled by hypridle
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
        wallpaper.enabled = false; # handled by swaybg
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
      };
  };
}
