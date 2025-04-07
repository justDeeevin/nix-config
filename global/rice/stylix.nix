{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  stylix = {
    enable = true;

    image = ./scp_3001_by_sunnyclockwork.jpg;
    imageScalingMode = "center";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";

    fonts = {
      monospace = {
        package = pkgs.monaspace;
        name = "Monaspace Neon";
      };
    };

    cursor = {
      package = pkgs.runCommand "moveUp" { } ''
        mkdir -p $out/share/icons
        ln -s ${
          pkgs.fetchzip {
            url = "https://github.com/justDeeevin/files/raw/refs/heads/main/posy-s-cursor.tar.xz";
            hash = "sha256-eeL9+3dcTX99xtUivfYt23R/jh8VIVqtMkoUPmk/12E=";
          }
        } $out/share/icons/Posy
      '';
      name = "Posy";
      size = 32;
    };

    targets = {
      nixvim.enable = false;
      hyprpaper.enable = lib.mkForce false;
      ghostty.enable = false;
    };
    opacity.desktop = 0.0;
  };
}
