{
  programs.hyprlock.settings.label = [
    {
      text = ''
        cmd[update:1000] echo "󰁹 $(cat /sys/class/power_supply/BAT0/capacity)%"
      '';
      position = "0, 6%";
      font_size = 35;
      font_family = "Monaspace neon";
      halign = "center";
    }
  ];
}
