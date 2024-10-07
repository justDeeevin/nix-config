{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    ntfs3g
    mangohud
    sidequest
    inputs.drg-mod-manager.packages.x86_64-linux.default
    BeatSaberModManager
    clonehero
    osu-lazer-bin
    slack
    davinci-resolve
  ];

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      ${builtins.readFile ../../global/wezterm.lua}
      config.front_end = "WebGpu"
      return config
    '';
  };
}
