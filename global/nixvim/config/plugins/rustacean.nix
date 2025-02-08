{
  programs.nixvim.plugins.rustaceanvim = {
    enable = true;
    settings.server.default_settings.rust-analyzer = {
      inlayHints = {
        chainingHints.enable = true;
        parameterHints.enable = true;
        typeHints.enable = true;
      };
      check = {
        allTargets = false;
        command = "clippy";
      };
      cargo = {
        features = "all";
      };
    };
  };
}
