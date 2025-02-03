{ pkgs, lib, ... }: {
  programs.nvf.settings.vim = {
    lazy.plugins."oil.nvim" = {
      enabled = true;
      package = pkgs.vimPlugins.oil-nvim;
      setupModule = "oil";

      setupOpts = {
        view_options = {
          show_hidden = true;
          is_always_hidden = lib.generators.mkLuaInline
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
