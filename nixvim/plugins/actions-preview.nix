{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [ actions-preview-nvim ];

  autoCmd = [
    {
      event = "VimEnter";
      command = "lua require('actions-preview').setup({})";
      once = true;
    }
  ];

  keymaps = [
    {
      key = "<leader>ca";
      action.__raw = "require('actions-preview').code_actions";
    }
  ];
}
