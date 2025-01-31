{
  programs.nvf.settings.vim.autocomplete.nvim-cmp = {
    enable = true;
    mappings = {
      next = "<Down>";
      previous = "<Up>";
    };
    setupOpts.completion.completeopt = "menu, menuone";
    sourcePlugins = [
      "cmp-nvim-lsp"
      "cmp-path"
    ];
  };
}
