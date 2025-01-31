{ lib, ... }:
let inherit (lib.generators) mkLuaInline;
in {
  programs.nvf.settings.vim = {
    notes.obsidian = {
      enable = true;
      setupOpts = {
        dir = "~/Documents/Third Brain";
        daily_notes = {
          folder = "Daily";
          template = "Templates/Daily Note Template.md";
          date_format = "%b %-d, %Y";
        };
        templates.subdir = "Templates";
        disable_frontmatter = true;
        attachments = {
          img_folder = "Assets";
          img_name_func = mkLuaInline ''
            function()
              local date = os.date("*t")
              return string.format("Pasted image %d%d%d%d%d%d", date.year, date.month, date.day, date.hour, date.min, date.sec)
            end
          '';
          img_text_func = mkLuaInline ''
            function(client, path)
              path = client:vault_relative_path(path) or path
              return string.format("![[%s]]", path.name)
            end
          '';
        };
      };
    };
    options.conceeallevel = 2;
    keymaps = [
      {
        key = "<leader>ot";
        action = "<cmd>ObsidianToday<CR>";
      }
      {
        key = "<leader>op";
        action = "<cmd>ObsidianPasteImg<CR>";
      }
    ];
  };
}
