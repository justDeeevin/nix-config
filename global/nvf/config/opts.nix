{ lib, ... }:
{
  programs.nvf.settings.vim = {
    searchCase = "smart";
    options = {
      number = true;
      hlsearch = false;
      incsearch = true;
      list = true;
      listchars =
        {
          tab = "» ";
          trail = "·";
          nbsp = "␣";
          space = "⋅";
          eol = "↴";
        }
        |> lib.mapAttrsToList (name: value: "${name}:${value},")
        |> lib.concatStrings;
      showmode = false;
      breakindent = true;
      undofile = true;
      termguicolors = true;
      updatetime = 250;
      timeoutlen = 300;
    };
  };
}
