{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./config
  ];
  programs.nixvim = {
    enable = true;
    package = inputs.neovim-nightly.packages.x86_64-linux.default;
    defaultEditor = true;
  };
}
