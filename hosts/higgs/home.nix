{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./hypr.nix
  ];
  sops.secrets.OPENAI_API_KEY.sopsFile = ./secrets.yaml;

  programs.niri.settings = {
    outputs.eDP-1.backdrop-color = "010101";
    binds =
      let
        inherit (config.lib.niri.actions) spawn;
        brightnessctl = lib.getExe pkgs.brightnessctl;
      in
      {
        "XF86MonBrightnessUp" = {
          action = spawn brightnessctl "set" "+5%";
          allow-when-locked = true;
        };
        "XF86MonBrightnessDown" = {
          action = spawn brightnessctl "set" "5%-";
          allow-when-locked = true;
        };
      };
  };

  programs.hyprlock.settings = {
    general.ignore_empty_input = lib.mkForce false;
    input-field = lib.mkForce null;
    label = lib.mkForce [
      {
        text = "<b>$TIME12</b>";
        halign = "center";
        font_size = 50;
        font_family = "Monaspace Neon";
      }
    ];
  };
}
