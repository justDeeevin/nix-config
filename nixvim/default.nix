{ inputs, ... }:
{
  imports = [
    ./remaps.nix
    ./opts.nix
    ./diagnostics.nix
    ./lsp.nix
  ]
  ++ builtins.map (file: ./. + "/plugins/${file}") (builtins.attrNames (builtins.readDir ./plugins));

  colorschemes.oxocarbon.enable = true;
  highlightOverride.FloatBorder.link = "@boolean";
  package = inputs.nightly-nvim.packages.x86_64-linux.default;
}
