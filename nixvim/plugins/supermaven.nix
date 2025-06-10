{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [ supermaven-nvim ];

  autoCmd = [
    {
      # On startup, silently setup supermaven
      event = "VimEnter";
      command = "lua require('supermaven-nvim').setup({})";
      once = true;
    }
  ];
}
