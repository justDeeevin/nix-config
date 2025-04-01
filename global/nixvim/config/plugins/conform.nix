{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          css = [ "prettierd" ];
          html = [ "prettierd" ];
          javascript = [ "prettierd" ];
          javascriptreact = [ "prettierd" ];
          json = [ "prettierd" ];
          lua = [ "stylua" ];
          markdown = [ "prettierd" ];
          nix = [ "nixfmt" ];
          python = [ "black" ];
          rust = [ "rustfmt" ];
          scss = [ "prettierd" ];
          sh = [ "beautysh" ];
          svelte = [ "prettierd" ];
          toml = [ "taplo" ];
          typescript = [ "prettierd" ];
          typescriptreact = [ "prettierd" ];
          yaml = [ "yamlfmt" ];
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

    userCommands.Wnf.command.__raw = ''
      function(args)
        vim.b.disable_autoformat = true
        vim.api.nvim_command("write")
        vim.b.disable_autoformat = false
      end
    '';

    extraPackages = with pkgs; [
      beautysh
      black
      nixfmt-rfc-style
      prettierd
      stylua
      taplo
      yamlfmt
    ];
  };
}
