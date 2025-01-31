{ inputs, ... }: {
  imports = [ inputs.nvf.homeManagerModules.default ./config ];
  programs.nvf = {
    # enable = true;
    settings.vim.package = inputs.nvf.packages.x86_64-linux.default;
  };
}
