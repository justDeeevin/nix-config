{
  plugins.conform-nvim = {
    enable = true;
    autoInstall.enable = true;
    settings = {
      formatters_by_ft = {
        nu = [ "nufmt" ];
        python = [ "black" ];
      };
      format_on_save.lsp_format = "prefer";
    };
  };
}
