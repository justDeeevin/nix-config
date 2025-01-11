{pkgs, ...}: {
  programs.nvf.settings.vim.lazy.plugins."vimplugin-supermaven-nvim" = {
    package = pkgs.vimPlugins.supermaven-nvim;
    setupModule = "supermaven-nvim";
  };
}
