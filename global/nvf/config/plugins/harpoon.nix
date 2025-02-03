{ pkgs, ... }:
{
  programs.nvf.settings.vim = {
    lazy.plugins."harpoon2" = {
      enabled = true;
      package = pkgs.vimPlugins.harpoon2;
      setupModule = "harpoon";
    };

    keymaps = [
      {
        key = "<leader>a";
        lua = true;
        action = "function() require('harpoon'):list():add() end";
        mode = "n";
      }
      {
        key = "<C-e>";
        lua = true;
        action = "require('harpoon.ui').toggle_quick_menu";
        mode = "n";
      }
    ];
  };
}
