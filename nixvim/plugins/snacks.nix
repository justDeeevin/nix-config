{ pkgs, ... }:
{
  plugins.snacks =
    let
      mkEnabled =
        snacks:
        builtins.listToAttrs (
          builtins.map (
            snack:
            if builtins.isAttrs snack then
              {
                inherit (snack) name;
                value = builtins.removeAttrs snack [ "name" ];
              }
            else
              {
                name = snack;
                value.enabled = true;
              }
          ) snacks
        );
    in
    {
      enable = true;
      settings = mkEnabled [
        "indent"
        "picker"
        "scroll"
        "words"
        "image"
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
