{ pkgs, lib, ... }:
{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;

      keymaps = {
        diagnostic."<leader>v" = "open_float";
        lspBuf = {
          "gh" = "hover";
          "<F2>" = "rename";
        };
        extra = [
          {
            key = "<leader>th";
            action.__raw = "function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end";
          }
        ];
      };

      servers = {
        bashls.enable = true;
        denols = {
          enable = true;
          rootDir = "require('lspconfig').util.root_pattern('deno.json', 'deno.jsonc')";
        };
        html.enable = true;
        jdtls.enable = true;
        jsonls.enable = true;
        lua_ls.enable = true;
        nil_ls = {
          enable = true;
          package = pkgs.nil.overrideDerivation (old: rec {
            src = pkgs.fetchFromGitHub {
              owner = "oxalica";
              repo = "nil";
              rev = "52304da8e9748feff559ec90cb1f4873eda5cee1";
              hash = "sha256-MfSA8T+4q/FzQVg7gSy4AG7EdVgZ1qt11n7Q8o30uWA=";
            };
            cargoDeps = old.cargoDeps.overrideAttrs (
              lib.const {
                inherit src;
                name = "${old.pname}-vendor.tar.gz";
                outputHash = "sha256-RWgknkeGNfP2wH1X6nc+b10Qg1QX3UeewDdeWG0RIE8=";
              }
            );
          });
        };
        nushell.enable = true;
        svelte.enable = true;
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
                  languages = [ "vue" ];
                }
              ];
            };
            single_file_support = false;
          };
        };
        ltex = {
          enable = true;
          filetypes = [
            "markdown"
            "asciidoc"
          ];
          settings = {
            hiddenFalsePositives.en-US =
              [
                {
                  rule = "MORFOLOGIK_RULE_EN_US";
                  sentence = ''\w*footnote'';
                }
              ]
              |> builtins.map builtins.toJSON;
            dictionary.en-US = import ../dictionary.nix;
            disabledRules.en-US = [
              "AI"
              "EN_UNPAIRED_BRACKETS"
            ];
          };
        };
        volar = {
          enable = true;
          package = pkgs.vue-language-server;
        };
      };
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
  };
}
