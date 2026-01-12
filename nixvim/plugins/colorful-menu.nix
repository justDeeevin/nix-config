{
  plugins.colorful-menu.enable = true;

  plugins.blink-cmp.settings.completion.menu.draw = {
    columns = [
      [ "kind_icon" ]
      {
        __unkeyed = "label";
        gap = 1;
      }
    ];
    components.label = {
      text.__raw =
        # lua
        ''
          function(ctx)
            return require('colorful-menu').blink_components_text(ctx)
          end
        '';
      highlight.__raw =
        # lua
        ''
          function(ctx)
            return require('colorful-menu').blink_components_highlight(ctx)
          end
        '';
    };
  };
}
