{
  # Import all your configuration modules here
  imports =
    [
      ./remaps.nix
      ./opts.nix
      ./diagnostics.nix
    ]
    ++ builtins.map (file: ./. + "/plugins/${file}") (builtins.attrNames (builtins.readDir ./plugins));

  programs.nixvim.colorschemes.oxocarbon.enable = true;
}
