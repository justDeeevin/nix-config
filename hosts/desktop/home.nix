{pkgs, ...}: {
  home.packages = with pkgs; [
    ntfs3g
    mangohud
    sidequest
    BeatSaberModManager
    slack
  ];
}
