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
      options.nowait = true;
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
      options.desc = "Move line up";
    }
    {
      key = "N";
      action = ":m '>+1<CR>gv=gv";
      mode = "v";
      options.desc = "Move line down";
    }

    {
      key = "en";
      action = "<Esc>";
      mode = "i";
    }

    # Change windows
    {
      key = "<A-m>";
      action = "<cmd>wincmd h<CR>";
      mode = "n";
      options.desc = "Switch to left pane";
    }
    {
      key = "<A-n>";
      action = "<cmd>wincmd j<CR>";
      mode = "n";
      options.desc = "Switch to bottom pane";
    }
    {
      key = "<A-e>";
      action = "<cmd>wincmd k<CR>";
      mode = "n";
      options.desc = "Switch to top pane";
    }
    {
      key = "<A-i>";
      action = "<cmd>wincmd l<CR>";
      mode = "n";
      options.desc = "Switch to right pane";
    }
  ];
}
