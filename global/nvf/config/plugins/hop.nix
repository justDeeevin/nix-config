{
  programs.nvf.settings.vim = {
    utility.motion.hop = {
      enable = true;
    };
    keymaps = [
      {
        key = "<leader>i";
        lua = true;
        action = "lua require('hop').hint_char1({direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true})";
      }
      {
        key = "<leader>m";
        lua = true;
        action = "require('hop').hint_char1({direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true})";
      }
    ];
  };
}
