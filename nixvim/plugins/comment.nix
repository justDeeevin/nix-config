{
  plugins.comment = {
    enable = true;
    settings = {
      pre_hook.__raw =
        # lua
        ''
          function(ctx)
            if vim.bo.filetype ~= "c" then
              return
            end
            return "/* %s */"
          end
        '';
      toggler.line = "<C-/>";
      opleader = {
        line = "<C-/>";
        block = "<C-/>";
      };
    };
  };
}
