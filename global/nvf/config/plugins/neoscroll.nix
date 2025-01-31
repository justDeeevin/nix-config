{ pkgs, ... }: {
  programs.nvf.settings.vim.lazy.plugins."vimplugin-neoscroll.nvim" = {
    package = pkgs.vimPlugins.neoscroll-nvim;
    setupModule = "neoscroll";

    setupOpts = { mappings = [ "<C-u>" "<C-d>" ]; };
  };
}
