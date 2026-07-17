{ pkgs, myLib, ... }:
{
  plugins.lspconfig.enable = true;

  lsp = {
    servers = myLib.mkEnableList [
      "bashls"
      "clangd"
      "cssls"
      {
        name = "emmet_language_server";
        config.filetypes = [
          "html"
          "svelte"
          "typescriptreact"
        ];
      }
      "dartls"
      {
        name = "hls";
        package = pkgs.haskellPackages.haskell-language-server;
        packageFallback = true;
      }
      "html"
      "jdtls"
      "jsonls"
      "lua_ls"
      "nil_ls"
      "nushell"
      "ocamllsp"
      {
        name = "omnisharp";
        config.filetypes = [ "cs" ];
      }
      "pyright"
      {
        name = "rust_analyzer";
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
      }
      "svelte"
      {
        name = "tailwindcss";
        config.filetypes = [
          "html"
          "svelte"
          "typescriptreact"
        ];
      }
      "taplo"
      "tinymist"
      {
        name = "ts_ls";
        config.root_markers = [ "package.json" ];
      }
      "yamlls"
    ];

    keymaps = [
      {
        key = "<leader>v";
        action.__raw = "vim.diagnostic.open_float";
        options.desc = "Show diagnostics for this line";
      }
      {
        key = "gh";
        lspBufAction = "hover";
        options.desc = "Hover";
      }
      {
        key = "<F2>";
        lspBufAction = "rename";
        options.desc = "Rename";
      }
      {
        key = "<leader>th";
        action.__raw = "function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end";
        options.desc = "Toggle inlay hints";
      }
    ];
  };

  filetype.extension.webc = "html";

  extraPackages = [ pkgs.haskellPackages.ghc ];
}
