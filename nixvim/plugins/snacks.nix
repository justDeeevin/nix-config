{ pkgs, myLib, ... }:
{
  plugins.snacks =

    {
      enable = true;
      settings = myLib.mkEnableList [
        "image"
        "indent"
        "notifier"
        "picker"
        "scroll"
        "words"
      ];
    };

  keymaps = [
    {
      key = "<leader>sd";
      action.__raw = "Snacks.picker.diagnostics";
    }
    {
      key = "<leader>sf";
      action.__raw = "Snacks.picker.files";
    }
    {
      key = "<leader>sg";
      action.__raw = "Snacks.picker.grep";
    }
    {
      key = "gd";
      action.__raw = "Snacks.picker.lsp_definitions";
    }
    {
      key = "gr";
      action.__raw = "Snacks.picker.lsp_references";
    }
    {
      key = "<leader>sr";
      action.__raw = "Snacks.picker.resume";
    }
  ];
  extraPackages = [ pkgs.imagemagick ];
}
