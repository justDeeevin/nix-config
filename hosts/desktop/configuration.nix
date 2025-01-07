{pkgs, ...}: {
  imports = [./hardware-configuration.nix];

  programs.adb.enable = true;

  programs.alvr.enable = true;
  programs.alvr.openFirewall = true;

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  environment.etc."archon/bootstrap.json" = {
    enable = true;
    text = builtins.toJSON {
      nodes = [
        {
          name = "devin-pc";
          ip = "127.0.0.1";
          port = 8888;
        }
      ];
    };
  };

  services.hardware.openrgb.enable = true;

  services.udev.packages = [pkgs.qmk-udev-rules];
}
