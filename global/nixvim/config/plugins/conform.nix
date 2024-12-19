{pkgs, ...}: {
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          lua = ["stylua"];
          python = ["black"];
          javascript = ["prettierd"];
          javascriptreact = ["prettierd"];
          typescript = ["prettierd"];
          typescriptreact = ["prettierd"];
          json = ["prettierd"];
          html = ["prettierd"];
          css = ["prettierd"];
          markdown = ["prettierd"];
          yaml = ["yamlfmt"];
          toml = ["taplo"];
          svelte = ["prettierd"];
          nix = ["alejandra"];
          scss = ["prettierd"];
          sh = ["beautysh"];
          tex = ["latexindent"];
          rust = ["rustfmt"];
        };
        format_on_save.__raw = ''
          function(bufnr)
            if vim.b[bufnr].disable_autoformat then
              return
            end
            return { timeout_ms = 1000 }
          end
        '';
      };
    };

    userCommands.Wnf = {
      command.__raw = ''
        function(args)
          vim.b.disable_autoformat = true
          vim.api.nvim_command("write")
          vim.b.disable_autoformat = false
        end
      '';
    };

    extraPackages = with pkgs; [
      stylua
      black
      prettierd
      yamlfmt
      taplo
      alejandra
      beautysh
      texlivePackages.latexindent
    ];
  };
}
