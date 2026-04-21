{
  plugins.which-key = {
    enable = true;
    settings.spec =
      builtins.map
        (
          mapping:
          (builtins.removeAttrs mapping [
            "lhs"
          ])
          // {
            __unkeyed-1 = mapping.lhs;
            mode = [
              "o"
              "x"
            ];
          }
        )
        [
          {
            lhs = "gi";
            __unkeyed-2 = "i";
            group = "inside";
          }
          {
            lhs = "gi\"";
            desc = "inner \" string";
          }
          {
            lhs = "gi'";
            desc = "inner ' string";
          }
          {
            lhs = "gi(";
            desc = "inner [(])";
          }
          {
            lhs = "gi)";
            desc = "inner [(])";
          }
          {
            lhs = "gi<";
            desc = "inner <>";
          }
          {
            lhs = "gi>";
            desc = "inner <>";
          }
          {
            lhs = "giB";
            desc = "inner [{]}";
          }
          {
            lhs = "giW";
            desc = "inner WORD";
          }
          {
            lhs = "gi[";
            desc = "inner []";
          }
          {
            lhs = "gi]";
            desc = "inner []";
          }
          {
            lhs = "gi`";
            desc = "inner ` string";
          }
          {
            lhs = "gib";
            desc = "inner [(])";
          }
          {
            lhs = "gip";
            desc = "inner paragraph";
          }
          {
            lhs = "gis";
            desc = "inner sentence";
          }
          {
            lhs = "git";
            desc = "inner tag block";
          }
          {
            lhs = "giw";
            desc = "inner word";
          }
          {
            lhs = "gi{";
            desc = "inner [{]}";
          }
          {
            lhs = "gi}";
            desc = "inner [{]}";
          }
        ];
  };

  keymaps = [
    {
      key = "<leader>?";
      action.__raw = "function() require('which-key').show({global = false}) end";
      options.desc = "which-key";
    }
  ];
}
