{
  pkgs,
  lib,
  ...
}:
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      color = lib.mkForce "010101";
      clock = true;
      timestr = "%I:%M %p";
      indicator = true;
      indicator-y-position = 100;
    };
  };
}
