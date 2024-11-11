{pkgs, ...}: {
  home.packages = with pkgs; [
    ntfs3g
    mangohud
    sidequest
    BeatSaberModManager
    slack
  ];

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      ${builtins.readFile ../../global/wezterm.lua}
      return config
    '';
  };
}
