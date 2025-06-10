{
  plugins.hop.enable = true;
  keymaps = [
    {
      key = "<leader>i";
      action = "<cmd>lua require('hop').hint_char1({direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true})<CR>";
    }
    {
      key = "<leader>m";
      action = "<cmd>lua require('hop').hint_char1({direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true})<CR>";
    }
  ];
}
