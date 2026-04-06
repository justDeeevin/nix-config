{
  plugins.which-key = {
    enable = true;
  };
  keymaps = [
    {
      key = "<leader>?";
      action.__raw = "function() require('which-key').show({global = false}) end";
      options.desc = "which-key";
    }
  ];
}
