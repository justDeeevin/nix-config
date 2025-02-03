{ pkgs, ... }: {
  programs.nvf.settings.vim = {
    telescope = {
      enable = true;
      mappings = {
        resume = "<leader>sr";
        liveGrep = "<leader>sg";
        diagnostics = "<leader>sd";
        findFiles = "<leader>sf";
        lspDefinitions = "gd";
        lspReferences = "gr";
      };
    };
    # Unsure if necessary
    # extraPackages = [pkgs.ripgrep];
  };
}
