{pkgs, ...}: {
  home.packages = with pkgs; [
    ntfs3g
    mangohud
    sidequest
    BeatSaberModManager
    slack
  ];

  wayland.windowManager.hyprland.settings.monitor = "HDMI-A-1, highres@highrr, 0x0, 1, transform, 3";
}
