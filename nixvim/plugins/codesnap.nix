{ pkgs, ... }:
let
  version = "2.0.0-beta.17";
  dot_version = "2.0.0-beta.16"; # The 2.0.0-beta.17 release has the wrong version in project.toml
  os = if pkgs.stdenv.isLinux then "linux" else "mac";
  arch =
    if pkgs.stdenv.isLinux then
      pkgs.stdenv.hostPlatform.linuxArch
    else
      pkgs.stdenv.hostPlatform.darwinArch;
  generator_filename = "${os}-${arch}_generator.so";
  linux_generator = pkgs.fetchurl {
    url = "https://github.com/mistricky/codesnap.nvim/releases/download/v${version}/${generator_filename}";
    hash = "sha256-ew8c7/A9saudklWY/oIaWnoqsK9pyiSN9QM4YMizW44=";
  };
in
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "codesnap-nvim";
      inherit version;
      src = pkgs.fetchFromGitHub {
        owner = "mistricky";
        repo = "codesnap.nvim";
        tag = "v${version}";
        hash = "sha256-d7qiDqNVuJ/KGer3eZomCQoLUnSrGYflvvr77O+/1Ig=";
      };

      postInstall =
        # sh
        ''
          mkdir $out/lua/libs
          ln -s ${linux_generator} $out/lua/libs/${generator_filename}
          echo "${dot_version}" > $out/lua/libs/.version
        '';
    })
  ];

  extraConfigLua =
    # lua
    ''
      require("codesnap").setup({
        -- snapshot_config = {
        --   window = {
        --     margin = {
        --       x = 40,
        --       y = 25,
        --     },
        --   },
        --   code_config = {
        --     font_family = "Monaspace Neon",
        --     watermark = {
        --       content = "",
        --     },
        --   },
        -- },
      })
    '';
}
