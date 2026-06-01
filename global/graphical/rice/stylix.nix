{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.stylix.homeModules.stylix ];

  stylix = {
    enable = true;

    image = ./scp_3001_by_sunnyclockwork.jpg;
    imageScalingMode = "center";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
    polarity = "dark";

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

    targets = builtins.listToAttrs (
      builtins.map
        (name: {
          inherit name;
          value.enable = false;
        })
        [
          "bat"
          "btop"
          "ghostty"
          "nixcord"
          "nixvim"
          "noctalia-shell"
          "nushell"
          "starship"
        ]
    );
    opacity = {
      desktop = 1.0;
      terminal = 0.5;
    };

    overlays.enable = false;
  };
}
