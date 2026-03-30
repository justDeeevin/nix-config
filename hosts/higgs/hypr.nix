{ lib, ... }:
{
  programs.hyprlock.settings.label = lib.mkForce [
    {
      text = "<b>$TIME12</b>";
      halign = "center";
      position = "0, 5%";
      font_size = 50;
      font_family = "Monaspace Neon";
    }
    {
      text = ''
        cmd[update:1000] echo "󰁹 $(cat /sys/class/power_supply/BAT0/capacity)%"
      '';
      font_size = 35;
      font_family = "Monaspace neon";
      halign = "center";
    }
  ];
}
