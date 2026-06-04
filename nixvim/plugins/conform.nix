{
  plugins.conform-nvim = {
    enable = true;
    autoInstall.enable = true;
    settings = {
      formatters_by_ft = {
        nu = [ "nufmt" ];
        ocaml = [ "ocamlformat" ];
        python = [ "black" ];
        typescript = [ "prettier" ];
        javascript = [ "prettier" ];
      };
      format_on_save.__raw =
        # lua
        ''
          function()
            if not vim.b.disable_autoformat then
              local ft = vim.bo.filetype
              local never_ls = {"typescript", "javascript", "json", "ocaml"}
              if vim.tbl_contains(never_ls, ft) then
                return {}
              else
                return { lsp_format = "prefer" }
              end
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
