{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [ actions-preview-nvim ];

  extraConfigLua =
    # lua
    ''
      require('actions-preview').setup({})
    '';

  keymaps = [
    {
      key = "<leader>ca";
      action.__raw = "require('actions-preview').code_actions";
    }
  ];
}
