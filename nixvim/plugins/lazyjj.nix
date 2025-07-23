{ pkgs, ... }:
{
  extraPlugins = [ pkgs.vimPlugins.lazyjj-nvim ];
  extraConfigLua =
    # lua
    ''
      require("lazyjj").setup({mapping = "<leader>j"})
    '';
}
