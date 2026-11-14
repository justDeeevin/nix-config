{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
let
  cfg = config.programs.nixvim;
in
{
  options.programs.nixvim = {
    enable = lib.mkOption {
      default = true;
      type = lib.types.bool;
    };
    extraModules = lib.mkOption {
      default = [ ];
      type = lib.types.listOf lib.types.deferredModule;
    };
  };

  config.environment.systemPackages =
    lib.optional cfg.enable
      ((inputs.self.nixvimConfig pkgs.stdenv.hostPlatform.system).extendModules {
        modules = cfg.extraModules;
      }).config.build.package;
}
