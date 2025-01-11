{pkgs, ...}: {
  programs.nvf.settings.vim = {
    startPlugins = with pkgs.vimPlugins; [
      dressing-nvim
      rainbow-delimiters-nvim
      sleuth
    ];

    autopairs.nvim-autopairs.enable = true;
    ui.colorizer.enable = true;
    git.gitsigns.enable = true;
    utility.images.image-nvim.enable = true;
    presence.neocord.enable = true;
    treesitter.highlight.enable = true;
    visuals = {
      fidget-nvim.enable = true;
      indent-blankline.enable = true;
      nvim-web-devicons.enable = true;
    };
  };
}
