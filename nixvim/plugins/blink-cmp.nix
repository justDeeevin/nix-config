{
  plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap.preset = "enter";
      fuzzy.implementation = "lua";
      sources.default = [
        "lsp"
        "path"
        "snippets"
      ];
    };
  };
}
