{
  plugins.nabla.enable = true;
  keymaps = [
    {
      key = "<leader>p";
      action.__raw = "require('nabla').popup";
    }
  ];
}
