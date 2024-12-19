{
  programs.nixvim.opts = {
    number = true;
    relativenumber = true;
    ignorecase = true;
    smartcase = true;
    hlsearch = false;
    incsearch = true;
    list = true;
    listchars = {
      tab = "» ";
      trail = "·";
      nbsp = "␣";
      space = "⋅";
      eol = "↴";
    };
    showmode = false;
    breakindent = true;
    undofile = true;
    termguicolors = true;
    scrolloff = 8;
    updatetime = 250;
    timeoutlen = 300;
  };
}
