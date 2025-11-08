{ lib, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };

      background = lib.mkForce {
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
      };

      label = [
        {
          text = "<b>$TIME12</b>";
          position = "0, 10%";
          halign = "center";
          font_size = 50;
          font_family = "Monaspace Neon";
        }
      ];
    };
  };
}
