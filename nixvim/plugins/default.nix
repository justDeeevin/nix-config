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
    "supermaven"
    "todo-comments"
    "web-devicons"
  ];
}
