{ pkgs, ... }: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [ actions-preview-nvim ];

    autoCmd = [{
      # On startup, silently etup supermaven
      event = "VimEnter";
      command = "lua require('actions-preview').setup({})";
      once = true;
    }];

    keymaps = [{
      key = "<leader>ca";
      action = "<cmd>lua require('actions-preview').code_actions()<CR>";
    }];
  };
}
