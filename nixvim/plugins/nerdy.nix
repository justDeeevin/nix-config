{
  plugins.nerdy = {
    enable = true;
  };
  keymaps = [
    {
      key = "<leader>d";
      action = "<cmd>Nerdy list<CR>";
      options.desc = "Nerd icons";
    }
  ];
  extraConfigLua = ''
    require("nerdy").setup()
  '';
}
