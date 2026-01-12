{ pkgs, lib, ... }:
{
  programs.ghostty = {
    package = pkgs.ghostty-bin;
    settings.window-decoration = lib.mkForce "auto";
  };
}
