{ pkgs, ... }:
{
  programs.nvf.settings.vim.lazy.plugins."supermaven-nvim" = {
    enabled = true;
    package = pkgs.vimPlugins.supermaven-nvim;
    setupModule = "supermaven-nvim";
  };
}
