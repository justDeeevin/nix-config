{
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    ntfs3g
    gzdoom
    prismlauncher
    gimp
    reaper
  ];

  programs.niri.settings = {
    outputs.DP-1 = {
      backdrop-color = "010101";
      variable-refresh-rate = true;
      mode = {
        height = 1440;
        width = 2560;
        refresh = 239.999;
      };
      position = {
        x = 1080;
        y = (1920 - 1440) / 2;
      };
    };
    outputs.HDMI-A-1 = {
      backdrop-color = "010101";
      position = {
        x = 0;
        y = 0;
      };
      transform.rotation = 270;
    };
    spawn-at-startup = [
      {
        argv = [
          (lib.getExe pkgs.openrgb)
          "-p"
          (builtins.toString ./icy.orp)
        ];
      }
      {
        argv = [
          "slack"
          "--startup"
        ];
      }
    ];
    window-rules = [
      {
        matches = [ { app-id = "equibop"; } ];
        open-maximized = true;
      }
    ];
  };

  sops.secrets.OPENAI_API_KEY.sopsFile = ./secrets.yaml;
}
