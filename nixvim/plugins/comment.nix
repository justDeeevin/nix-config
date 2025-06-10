{
  plugins.comment = {
    enable = true;
    settings.toggler = {
      line = "<C-/>";
    };
  };

  keymaps = [
    {
      key = "<C-/>";
      action = {
        __raw = ''
          function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
            require("Comment.api").toggle.linewise(vim.fn.visualmode())
          end
        '';
      };
      mode = "v";
    }
  ];
}
