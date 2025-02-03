{
  imports = [ ./remaps.nix ./opts.nix ]
    ++ builtins.map (file: ./. + "/plugins/${file}")
    (builtins.attrNames (builtins.readDir ./plugins));

  programs.nvf.settings.vim = {
    preventJunkFiles = true;

    theme = {
      enable = true;
      name = "oxocarbon";
      transparent = true;
      style = "dark";
    };
  };
}
