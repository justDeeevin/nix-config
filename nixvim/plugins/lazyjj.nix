{ pkgs, ... }:
{
  extraPlugins = [ pkgs.vimPlugins.lazyjj-nvim ];
  extraConfigLua = ''require("lazyjj").setup({mapping = "<leader>j"})'';
}
