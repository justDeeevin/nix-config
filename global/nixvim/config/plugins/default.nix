{
  programs.nixvim.plugins = {
    nvim-autopairs.enable = true;
    colorizer = {
      enable = true;
      settings.filetypes = [ "css" ];
    };
    dressing.enable = true;
    gitsigns.enable = true;
    image.enable = true;
    indent-blankline.enable = true;
    rainbow-delimiters.enable = true;
    sleuth.enable = true;
    fidget.enable = true;
    crates.enable = true;
    web-devicons.enable = true;
    lsp-lines.enable = true;
    smear-cursor.enable = true;
    cord.enable = true;
    transparent.enable = true;
    hardtime.enable = true;
    octo.enable = true;
    tailwind-tools.enable = true;
  };
}
