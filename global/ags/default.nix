{
  inputs,
  lib,
  config,
  ...
}: {
  options.programs.ags.modules = let
    inherit (lib) mkEnableOption;
  in {
    wifi = mkEnableOption "the wifi module in the bar";
    battery = mkEnableOption "the battery module in the bar";
  };

  config = {
    programs.ags = {
      enable = true;

      configDir = ./config;

      systemd.enable = true;

      extraPackages = with inputs.ags.packages.x86_64-linux; [
        notifd
        hyprland
        tray
        mpris
        apps
        wireplumber
        network
        battery
      ];
    };

    home.file.".config/bar-modules.json".text = builtins.toJSON config.programs.ags.modules;
  };
}
