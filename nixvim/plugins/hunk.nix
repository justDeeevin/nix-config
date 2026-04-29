{
  plugins.hunk = {
    enable = true;
    settings.keys = {
      global.accept = [ "<C-CR>" ];
      tree.toggle_file = [ "  " ];
      diff = {
        toggle_hunk = [ "<CR>" ];
        toggle_line = [ "  " ];
      };
    };
  };
}
