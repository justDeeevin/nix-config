{ myLib, ... }:
{
  plugins = myLib.mkEnableList [
    "cord"
    "crates"
    "fidget"
    "gitsigns"
    "helpview"
    "hex"
    "modicator"
    "nvim-autopairs"
    "rainbow-delimiters"
    "todo-comments"
    "web-devicons"
  ];
}
