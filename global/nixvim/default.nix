{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./config
  ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    nixpkgs.config.allowBroken = true;
  };
}
