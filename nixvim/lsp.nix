{
  plugins.lspconfig.enable = true;

  lsp = {
    servers = {
      bashls.enable = true;
      ccls.enable = true;
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
        config.settings.rust-analyzer = {
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
      slint_lsp.enable = true;
      svelte.enable = true;
      tailwindcss.enable = true;
      taplo.enable = true;
      ts_ls = {
        enable = true;
        config.root_markers = [ "package.json" ];
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
    {
      event = "BufWritePre";
      callback.__raw = ''
        function(event)
          if vim.b[event.buf].disable_autoformat then
            return
          end

          local original = vim.notify
          vim.notify = function(msg, level, opts)
            if msg == "[LSP] Format request failed, no matching language servers." then
              return
            end
            original(msg, level, opts)
          end

          vim.lsp.buf.format()

          vim.notify = original
        end
      '';
    }
  ];

  userCommands.Wnf.command.__raw = ''
    function(args)
      vim.b.disable_autoformat = true
      vim.api.nvim_command("write")
      vim.b.disable_autoformat = false
    end
  '';
}
