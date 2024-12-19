{
  programs.nixvim.plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      sources = [
        {name = "nvim_lsp";}
        {name = "path";}
      ];
      # This is the default with noselect removed. This change makes it select the first item automatically.
      completion.completeopt = "menu, menuone";
      mapping = {
        "<CR>" = "require('cmp').mapping.confirm({select = true})";
        "<C-Space>" = ''
          function()
            require("cmp").mapping.complete()
          end
        '';
        "<Down>" = ''
          function(fallback)
            if require("cmp").visible() then
              require("cmp").select_next_item()
            else
              fallback()
            end
          end
        '';
        "<Up>" = ''
          function(fallback)
            if require("cmp").visible() then
              require("cmp").select_prev_item()
            else
              fallback()
            end
          end
        '';
      };
    };
  };
}
