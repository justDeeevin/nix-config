{
  plugins.nerdy = {
    enable = true;
  };
  keymaps = [
    {
      key = "<leader>d";
      action = "<cmd>Nerdy list<CR>";
    }
  ];
  extraConfigLua = ''
    require("nerdy").setup()
  '';
}
