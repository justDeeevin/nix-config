{
  plugins.guess-indent.enable = true;

  keymaps = [
    {
      key = "<leader>gi";
      action = "<cmd>GuessIndent<CR>";
      options.desc = "Guess indentation";
    }
  ];
}
