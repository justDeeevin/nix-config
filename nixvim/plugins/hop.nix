{
  plugins.hop.enable = true;
  keymaps = [
    {
      key = "<leader>m";
      action.__raw = ''
        function()
          require('hop').hint_char1({
            direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
            current_line_only = true
          })
        end
      '';
      options.desc = "Hop left";
    }
    {
      key = "<leader>i";
      action.__raw = ''
        function()
          require('hop').hint_char1({
            direction = require('hop.hint').HintDirection.AFTER_CURSOR,
            current_line_only = true
          })
        end
      '';
      options.desc = "Hop right";
    }
  ];
}
