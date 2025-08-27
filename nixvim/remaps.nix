{
  globals.mapleader = " ";

  keymaps = [
    {
      # Colemak rebinding
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

    # Change windows
    {
      key = "<A-m>";
      action = ":wincmd h<CR>";
      mode = "n";
    }
    {
      key = "<A-n>";
      action = ":wincmd j<CR>";
      mode = "n";
    }
    {
      key = "<A-e>";
      action = "<cmd>wincmd k<CR>";
      mode = "n";
    }
    {
      key = "<A-i>";
      action = "<cmd>wincmd l<CR>";
      mode = "n";
    }
  ];
}
