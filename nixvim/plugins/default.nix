{
  plugins = builtins.listToAttrs (
    builtins.map
      (plugin: {
        name = plugin;
        value.enable = true;
      })
      [
        "nvim-autopairs"
        "dressing"
        "gitsigns"
        "image"
        "indent-blankline"
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
