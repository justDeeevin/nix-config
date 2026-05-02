{ inputs, lib, ... }:
{
  imports = [
    ./remaps.nix
    ./opts.nix
    ./diagnostics.nix
    ./lsp.nix
  ]
  ++ builtins.map (file: ./. + "/plugins/${file}") (
    builtins.filter (lib.hasSuffix ".nix") (builtins.attrNames (builtins.readDir ./plugins))
  );

  colorschemes.oxocarbon.enable = true;
  highlightOverride = {
    FloatBorder.link = "@boolean";
    Normal.bg = "none";
    LineNr.bg = "none";
    FoldColumn.bg = "none";
    SignColumn.bg = "none";
  };
  package = inputs.nightly-nvim.packages.x86_64-linux.default;
}
