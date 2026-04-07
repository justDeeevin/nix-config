{ pkgs, ... }:
{
  plugins.modicator = {
    enable = true;
    package = pkgs.applyPatches {
      name = "modicator.nvim-patched";
      src = pkgs.vimPlugins.modicator-nvim;
      patches = [ ./modicator.patch ];
    };
  };
}
