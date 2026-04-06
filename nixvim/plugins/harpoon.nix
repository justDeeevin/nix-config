{
  plugins.harpoon = {
    enable = true;
    settings.settings.save_on_toggle = true;
  };

  keymaps = [
    {
      key = "<leader>a";
      action.__raw = "function() require('harpoon'):list():add() end";
      options.desc = "Harpoon";
    }
    {
      key = "<C-e>";
      action.__raw = "function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end";
      options.desc = "Harpoon quick menu";
    }
  ];
}
