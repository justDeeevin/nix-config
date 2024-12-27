{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      servers = {
        nixd.enable = true;
        ts_ls = {
          enable = true;
          filetypes = [
            "typescript"
            "typescriptreact"
            "javascript"
            "javascriptreact"
            "vue"
          ];
          rootDir = "require('lspconfig').util.root_pattern('package.json')";
          extraOptions = {
            init_options = {
              plugins = [
                {
                  name = "@vue/typescript-plugin";
                  location = "${lib.getBin pkgs.vue-language-server}/lib/node_modules/@vue/language-server";
                  languages = ["vue"];
                }
              ];
            };
            single_file_support = false;
          };
        };
        volar = {
          enable = true;
          package = pkgs.vue-language-server;
        };
        lua_ls.enable = true;
        bashls.enable = true;
        jdtls.enable = true;
        jsonls.enable = true;
        svelte.enable = true;
        html.enable = true;
        denols = {
          enable = true;
          rootDir = "require('lspconfig').util.root_pattern('deno.json', 'deno.jsonc')";
        };
      };
    };

    keymaps = [
      {
        key = "gh";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
      }
      {
        key = "<leader>th";
        action = "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))<CR>";
      }
      {
        key = "<F2>";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        mode = "n";
      }
      {
        key = "<leader>v";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        mode = "n";
      }
    ];

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
        callback = {
          __raw = ''
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
        };
      }
      {
        event = "LspDetach";
        group = "lsp-detach";
        callback = {
          __raw = ''
            function(event)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({group = "lsp-highlight"})
            end
          '';
        };
      }
    ];
  };
}
