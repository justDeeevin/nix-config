{ pkgs, lib, ... }:
let
  version = "0.5.2";
  src = pkgs.fetchFromGitHub {
    owner = "justdeeevin";
    repo = "fff.nvim";
    rev = "resume";
    hash = "sha256-3IHpvGytJMVIg7UtID5tVTFo3mBwln6eyWd1XeDAQ/4=";
  };
  fff-nvim-lib = pkgs.rustPlatform.buildRustPackage {
    pname = "fff-nvim-lib";
    inherit version src;

    cargoHash = "sha256-vGu1Jx9OAIy9CZdm1rhvMiJvfysl7UF4stf6hWPzvhY=";

    cargoBuildFlags = [
      "-p"
      "fff-nvim"
      "--features"
      "zlob"
    ];

    nativeBuildInputs = with pkgs; [
      pkg-config
      perl
      rustPlatform.bindgenHook
    ];

    buildInputs = [ pkgs.openssl ];

    doCheck = false;

    env = {
      OPENSSL_NO_VENDOR = true;

      RUSTFLAGS = lib.optionalString pkgs.stdenv.hostPlatform.isDarwin "-C link-arg=-undefined -C link-arg=dynamic_lokup";

      ZIG = lib.getExe pkgs.zig;
    };
  };
  fff-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "fff.nvim";
    inherit version src;

    postPatch =
      # sh
      ''
        substituteInPlace lua/fff/download.lua\
          --replace-fail \
          "return plugin_dir .. '/../target/release'" \
          "return '${fff-nvim-lib}/lib'"
      '';

    nvimSkipModule = [
      "empty_config"
    ];

    passthru = {
      updateScript = pkgs.nix-update-script {
        attrPath = "vimPlugins.fff-nvim.fff-nvim-lib";
      };

      inherit fff-nvim-lib;
    };
  };
in
{
  plugins.fff = {
    enable = true;
    package = fff-nvim;
  };
}
