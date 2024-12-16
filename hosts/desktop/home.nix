{pkgs, ...}: {
  home.packages = with pkgs; [
    ntfs3g
  ];

  wayland.windowManager.hyprland.settings.monitor = [
    "HDMI-A-1, highres@highrr, 0x0, 1, transform, 3"
    "DP-1, highres@highrr, 1080x240, 1"
  ];

  programs.syspower.settings.monitor = 1;
}
