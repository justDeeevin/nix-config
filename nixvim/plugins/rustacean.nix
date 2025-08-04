{
  plugins.rustaceanvim = {
    enable = true;
    settings.server.default_settings.rust-analyzer = {
      inlayHints = {
        parameterHints.enable = true;
        typeHints.enable = true;
        lifetimeElisionHints.enable = "always";
      };
      check = {
        allTargets = false;
        command = "clippy";
        features = "all";
      };
      cargo = {
        features = "all";
      };
    };
  };
}
