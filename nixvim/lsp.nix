{
  plugins.lspconfig.enable = true;

  lsp = {
    servers = {
      bashls.enable = true;
      clangd.enable = true;
      cssls.enable = true;
      emmet_language_server = {
        enable = true;
        config.filetypes = [
          "html"
          "svelte"
          "typescriptreact"
        ];
      };
      html.enable = true;
      jdtls.enable = true;
      jsonls.enable = true;
      lua_ls.enable = true;
      nil_ls.enable = true;
      nushell.enable = true;
      omnisharp = {
        enable = true;
        config.filetypes = [ "cs" ];
      };
      pyright.enable = true;
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
      svelte.enable = true;
      tailwindcss = {
        enable = true;
        config.filetypes = [
          "html"
          "svelte"
          "typescriptreact"
        ];
      };
      taplo.enable = true;
      ts_ls = {
        enable = true;
        config.root_markers = [ "package.json" ];
      };
    };

    keymaps = [
      {
        key = "<leader>v";
        action.__raw = "vim.diagnostic.open_float";
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

  filetype.extension.webc = "html";
}
