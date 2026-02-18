{
  plugins.conform-nvim = {
    enable = true;
    autoInstall.enable = true;
    settings = {
      formatters_by_ft = {
        nu = [ "nufmt" ];
        python = [ "black" ];
      };
      format_on_save.__raw =
        # lua
        ''
          function()
            if not vim.b.disable_autoformat then
              return { lsp_format = "prefer" }
            end
          end
        '';
    };
  };

  userCommands.Wnf.command.__raw = ''
    function()
      vim.b.disable_autoformat = true
      vim.api.nvim_command("write")
      vim.b.disable_autoformat = false
    end
  '';
}
