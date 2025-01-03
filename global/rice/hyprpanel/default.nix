{
  inputs,
  config,
  ...
}: {
  imports = [inputs.hyprpanel.homeManagerModules.hyprpanel];

  programs.hyprpanel = {
    enable = true;
    overlay.enable = true;
    systemd.enable = true;
    hyprland.enable = true;
    settings.theme.bar.transparent = true;
    override.theme.bar = import ./colors.nix config;
  };
}
