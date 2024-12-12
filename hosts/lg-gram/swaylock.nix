{
  pkgs,
  lib,
  ...
}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      scaling = lib.mkForce "center";
      color = lib.mkForce "010101";
      clock = true;
      indicator = true;
      indicator-y-position = 100;
    };
  };
}
