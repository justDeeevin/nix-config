{
  pkgs,
  inputs,
  lib,
  ...
}: let
  scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
in {
  imports = [inputs.stylix.homeManagerModules.stylix inputs.base16.homeManagerModule];

  inherit scheme;

  stylix = {
    enable = true;

    image = ./scp_3001_by_sunnyclockwork.jpg;
    imageScalingMode = "center";

    base16Scheme = scheme;

    fonts = {
      monospace = {
        package = pkgs.monaspace;
        name = "Monaspace Neon";
      };
    };

    cursor = {
      package = pkgs.runCommand "moveUp" {} ''
        mkdir -p $out/share/icons
        ln -s ${pkgs.fetchzip {
          url = "https://cdn.discordapp.com/attachments/698251081569927191/1222751288941477978/posy-s-cursor.tar.xz?ex=66175ae0&is=6604e5e0&hm=6d2fdd7ce1c7b41cb56845093e2c0b9c7360cc8b29681d3da17c62c8ca162bc1&";
          hash = "sha256-eeL9+3dcTX99xtUivfYt23R/jh8VIVqtMkoUPmk/12E=";
        }} $out/share/icons/Posy
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
