{ pkgs, config, ... }:
{
  programs.vicinae = {
    enable = true;
    systemd.enable = true;
    themes.oxocarbon = {
      meta = {
        version = 1;
        name = "Oxocarbon";
        description = "High contrast accessible colorscheme inspired by IBM Carbon";
        variant = "dark";
        icon = pkgs.fetchurl {
          url = "https://avatars.githubusercontent.com/u/120229920";
          hash = "sha256-T6c2JMvRvwIiSNoY1cO4co1kRdtjLrixsoBkZKX1YAE=";
        };
      };

      colors =
        let
          colors = (config.stylix.base16.mkSchemeAttrs config.stylix.base16Scheme).withHashtag;
        in
        {
          core = rec {
            background = colors.base00;
            foreground = colors.base06;
            secondary_background = colors.base04;
            border = colors.base03;
            accent = colors.orange;
            accent_foreground = foreground;
          };

          accents = {
            inherit (colors)
              blue
              green
              orange
              red
              yellow
              cyan
              magenta
              ;
          };
        };
    };

  };
}
