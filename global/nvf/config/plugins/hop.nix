{
  programs.nvf.settings.vim = {
    utility.motion.hop = {
      enable = true;
    };
    keymaps = [
      {
        key = "<leader>i";
        lua = true;
        action = "function() require('hop').hint_char1({direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true}) end";
        mode = "n";
      }
      {
        key = "<leader>m";
        lua = true;
        action = "function() require('hop').hint_char1({direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true}) end";
        mode = "n";
      }
    ];
  };
}
