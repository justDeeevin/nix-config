{
  programs.nixvim = {
    plugins.oil = {
      enable = true;
      settings = {
        view_options = {
          show_hidden = true;
          is_always_hidden.__raw =
            "function(name, bufnr) return name == '.git' end";
        };
        skip_confirm_for_simple_edits = true;
        watch_for_changes = true;
      };
    };

    keymaps = [{
      key = "<leader>e";
      action = "<cmd>Oil<CR>";
      mode = "n";
    }];
  };
}
