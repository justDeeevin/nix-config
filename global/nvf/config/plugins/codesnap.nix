{ pkgs, ... }:
{
  programs.nvf.settings.vim.lazy.plugins."vimplugin-codesnap.nvim" = {
    package = pkgs.vimPlugins.codesnap-nvim;
    setupModule = "codesnap";
    setupOpts = {
      watermark = "";
      has_breadcrumbs = true;
      has_line_number = true;
      bg_theme = "sea";
    };
  };
}
