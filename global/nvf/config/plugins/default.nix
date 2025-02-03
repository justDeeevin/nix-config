{ pkgs, ... }:
{
  programs.nvf.settings.vim = {
    startPlugins = with pkgs.vimPlugins; [
      dressing-nvim
      sleuth
    ];

    autopairs.nvim-autopairs.enable = true;
    ui = {
      colorizer.enable = true;
      illuminate.enable = true;
    };
    git.gitsigns.enable = true;
    utility.images.image-nvim = {
      enable = true;
      setupOpts.backend = "kitty";
    };
    presence.neocord.enable = true;
    # treesitter.highlight.enable = true;
    visuals = {
      fidget-nvim.enable = true;
      # indent-blankline.enable = true;
      nvim-web-devicons.enable = true;
      cinnamon-nvim.enable = true;
      rainbow-delimiters.enable = true;
    };

    mini.indentscope.enable = true;
  };
}
