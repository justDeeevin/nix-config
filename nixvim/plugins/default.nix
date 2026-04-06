{
  plugins = builtins.listToAttrs (
    builtins.map
      (plugin: {
        name = plugin;
        value.enable = true;
      })
      [
        "nvim-autopairs"
        "gitsigns"
        "rainbow-delimiters"
        "fidget"
        "crates"
        "web-devicons"
        "cord"
        "transparent"
        "supermaven"
        "todo-comments"
        "modicator"
        "helpview"
      ]
  );
}
