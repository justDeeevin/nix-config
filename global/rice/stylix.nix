{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.stylix.homeModules.stylix ];

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
      package = pkgs.posy-cursors;
      name = "Posy_Cursor";
      size = 32;
    };

    targets = {
      nixvim.enable = false;
      hyprpaper.enable = lib.mkForce false;
      ghostty.enable = false;
      btop.enable = false;
      bat.enable = false;
    };
    opacity = {
      desktop = 1.0;
      terminal = 0.5;
    };
  };
}
