{
  plugins.nerdy = {
    enable = true;
    enableTelescope = true;
  };

  keymaps = [
    {
      key = "<leader>d";
      action.__raw = "require('telescope').extensions.nerdy.nerdy";
    }
  ];
}
