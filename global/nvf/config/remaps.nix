{
  programs.nvf.settings.vim = {
    keymaps = [
      # Colemak rebinding
      {
        key = "m";
        action = "h";
      }
      {
        key = "n";
        action = "j";
      }
      {
        key = "e";
        action = "k";
      }
      {
        key = "i";
        action = "l";
      }
      {
        key = "k";
        action = "n";
      }
      {
        key = "K";
        action = "N";
      }
      {
        key = "l";
        action = "u";
      }
      {
        key = "u";
        action = "i";
      }
      {
        key = "U";
        action = "I";
        mode = "v";
      }

      # Move selected lines up and down
      {
        key = "E";
        action = ":m '<-2<CR>gv=gv";
        mode = "v";
      }
      {
        key = "N";
        action = ":m '>+1<CR>gv=gv";
        mode = "v";
      }

      {
        key = "en";
        action = "<Esc>";
        mode = "i";
      }
    ];

    luaConfigPost = ''
      vim.api.nvim_create_user_command("Wnf", function()
          if vim.b.disableFormatSave then
            return
          end

          vim.b.disableFormatSave = true
          vim.api.nvim_command("write")
          vim.b.disableFormatSave = false
        end
      )
    '';
  };
}
