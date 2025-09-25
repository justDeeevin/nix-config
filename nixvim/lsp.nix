{
  plugins.lspconfig.enable = true;

  lsp = {
    servers = {
      bashls.enable = true;
      clangd.enable = true;
      denols = {
        enable = true;
        activate = false;
      };
      html.enable = true;
      jdtls.enable = true;
      jsonls.enable = true;
      lua_ls.enable = true;
      nil_ls.enable = true;
      nushell.enable = true;
      omnisharp.enable = true;
      rust_analyzer = {
        enable = true;
        settings.settings.rust-analyzer = {
          inlayHints = {
            parameterHints.enable = true;
            typeHints.enable = true;
            lifetimeElisionHints.enable = "always";
          };
          check = {
            allTargets = false;
            command = "clippy";
            features = "all";
          };
          cargo = {
            features = "all";
          };
        };
      };
      svelte.enable = true;
      tailwindcss.enable = true;
      ts_ls = {
        enable = true;
        # TODO: necessary?
        # filetypes = [
        #   "typescript"
        #   "typescriptreact"
        #   "javascript"
        #   "javascriptreact"
        #   "vue"
        # ];
        # single_file_support = false;
        settings.root_markers = [ "package.json" ];
      };
    };

    keymaps = [
      {
        key = "<leader>v";
        action.__raw = "function() vim.diagnostic.open_float() end";
      }
      {
        key = "gh";
        lspBufAction = "hover";
      }
      {
        key = "<F2>";
        lspBufAction = "rename";
      }
      {
        key = "<leader>th";
        action.__raw = "function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end";
      }
    ];
  };

  autoGroups = {
    lsp-highlight = {
      clear = false;
    };
    lsp-detach = {
      clear = true;
    };
    lsp-attach = {
      clear = true;
    };
  };

  autoCmd = [
    {
      event = "LspAttach";
      group = "lsp-attach";
      callback.__raw = ''
        function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = "lsp-highlight",
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = "lsp-highlight",
              callback = vim.lsp.buf.clear_references,
            })
          end
        end
      '';
    }
    {
      event = "LspDetach";
      group = "lsp-detach";
      callback.__raw = ''
        function(event)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({group = "lsp-highlight"})
        end
      '';
    }
  ];
}
