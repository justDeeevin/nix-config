{
  programs.nvf.settings.vim = {
    ui.illuminate.enable = true;
    luaConfigPost = "require('illuminate').configure({providers = {'lsp'}})";
  };
}
