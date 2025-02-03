{
  programs.nvf.settings.vim = {
    # TODO: unnecessary?
    syntaxHighlighting = true;
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
        format.type = "nixfmt";
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
      # TODO: deno
      ts.enable = true;
    };

    lsp = {
      # TODO: unnecessary?
      enable = true;
      lightbulb.enable = true;
      formatOnSave = true;
      lspsaga = {
        enable = true;
        mappings = {
          rename = "<F2>";
          showCursorDiagnostics = "<leader>v";
        };
      };
      mappings = {
        hover = "gh";
      };
      lsplines.enable = true;
    };
  };
}
