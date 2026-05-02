{
  plugins = builtins.listToAttrs (
    builtins.map
      (plugin: {
        name = plugin;
        value.enable = true;
      })
      [
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
      ]
  );
}
