{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      ${builtins.readFile ../../global/wezterm.lua}
      config.enable_wayland = false
      return config
    '';
  };
}
