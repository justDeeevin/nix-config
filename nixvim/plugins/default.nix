{ myLib, ... }:
{
  plugins = myLib.mkEnableList [
    "cord"
    "crates"
    "fidget"
    "gitsigns"
    "helpview"
    "hex"
    "lean"
    "modicator"
    "nvim-autopairs"
    "rainbow-delimiters"
    "supermaven"
    "todo-comments"
    "web-devicons"
  ];
}
