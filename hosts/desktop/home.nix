{
  pkgs,
  # inputs,
  ...
}: {
  home.packages = with pkgs; [
    ntfs3g
    mangohud
    sidequest
    # inputs.drg-mod-manager.packages.x86_64-linux.default
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
