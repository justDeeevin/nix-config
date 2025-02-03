{
  programs.nvf.settings.vim = {
    keymaps = [
      # Colemak rebinding
      {
        key = "m";
        action = "h";
        mode = [
          "n"
          "v"
          "o"
        ];
      }
      {
        key = "n";
        action = "j";
        mode = [
          "n"
          "v"
          "o"
        ];
      }
      {
        key = "e";
        action = "k";
        mode = [
          "n"
          "v"
          "o"
        ];
      }
      {
        key = "i";
        action = "l";
        mode = [
          "n"
          "v"
          "o"
        ];
      }
      {
        key = "k";
        action = "n";
        mode = [
          "n"
          "v"
          "o"
        ];
      }
      {
        key = "K";
        action = "N";
        mode = [
          "n"
          "v"
          "o"
        ];
      }
      {
        key = "l";
        action = "u";
        mode = [
          "n"
          "v"
          "o"
        ];
      }
      {
        key = "u";
        action = "i";
        mode = [
          "n"
          "v"
          "o"
        ];
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
  };
}
