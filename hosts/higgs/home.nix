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

  programs.niri.settings.binds =
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
}
