{ pkgs, ... }:
{
  programs.nvf.settings.vim = {
    lsp.formatOnSave = true;
    languages = {
      enableLSP = true;
      enableTreesitter = true;
      enableFormat = true;

      bash.enable = true;
      clang.enable = true;
      css.enable = true;
      html.enable = true;
      java.enable = true;
      markdown.enable = true;
      nix = {
        enable = true;
        lsp.package = pkgs.nixd;
      };
      nu.enable = true;
      rust = {
        enable = true;
        crates = {
          enable = true;
          codeActions = true;
        };
        # TODO: configure rust-analyzer
      };
      svelte.enable = true;
      ts.enable = true;
    };

    lsp = {
      lspsaga = {
        mappings = {
          rename = "<F2>";
          showCursorDiagnostics = "<leader>v";
        };
      };
      mappings = {
        hover = "gh";
      };
    };

    luaConfigPost = ''
      vim.g.rustaceanvim.server.default_settings.rust-analyzer = vim.list_extend(vim.g.rustaceanvim.server.default_settings.rust-analyzer, {
        inlayHints = {
          chainingHints = {
            enable = true,
            maxLength = 20,
            maxItems = 5,
          },
          typeHints = {
            enable = true,
          },
          parameterHints = {
            enable = true,
          },
        },
      })
    '';
  };
}
