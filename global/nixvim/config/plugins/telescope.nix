{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
        ui-select.enable = true;
      };
    };

    keymaps = [
      {
        key = "<leader>sf";
        action = "<cmd>lua require('telescope.builtin').find_files()<CR>";
      }
      {
        key = "<leader>sg";
        action = "<cmd>lua require('telescope.builtin').live_grep()<CR>";
      }
      {
        key = "<leader>sd";
        action = "<cmd>lua require('telescope.builtin').diagnostics()<CR>";
      }
      {
        key = "<leader>sr";
        action = "<cmd>lua require('telescope.builtin').resume()<CR>";
      }
      {
        key = "gd";
        action = "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>";
      }
      {
        key = "gr";
        action = "<cmd>lua require('telescope.builtin').lsp_references()<CR>";
      }
    ];

    extraPackages = with pkgs; [ ripgrep ];
  };
}
