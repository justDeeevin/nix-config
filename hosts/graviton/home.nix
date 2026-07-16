{
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    coppwr
    gimp
    (callPackage ./grimoire.nix { })
    kdePackages.kdenlive
    prismlauncher
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
      transform.rotation = 90;
    };
    spawn-at-startup = [
      {
        argv = [
          (lib.getExe pkgs.openrgb)
          "-p"
          (builtins.toString ./icy.orp)
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

  programs.nushell.extraConfig =
    # nu
    ''
      def headphones [] {
        pw-dump | from json | where info?.props."node.description"? == "Arctis Nova Pro Wireless Analog Stereo" | get id.0 | wpctl set-default $in
      }
      def speakers [] {
        pw-dump | from json | where info?.props."node.description"? == "Built-in Audio Analog Stereo" | get id.0 | wpctl set-default $in
      }
    '';
}
