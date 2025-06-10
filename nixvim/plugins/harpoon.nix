{
  plugins.harpoon = {
    enable = true;
    enableTelescope = true;
  };
  keymaps = [
    {
      key = "<leader>a";
      action.__raw = "function() require('harpoon'):list():add() end";
    }
    {
      key = "<C-e>";
      action.__raw = "function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end";
    }
  ];
}
