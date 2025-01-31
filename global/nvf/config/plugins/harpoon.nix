{ pkgs, ... }: {
  programs.nvf.settings.vim = {
    lazy.plugins."vimplugin-harpoon2" = {
      package = pkgs.vimPlugins.harpoon2;
      setupModule = "harpoon";
    };
    # copied from harpoon's gh
    luaConfigPost = ''
      local harpoon = require("harpoon")
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
          local file_paths = {}
          for _, item in ipairs(harpoon_files.items) do
              table.insert(file_paths, item.value)
          end

          require("telescope.pickers").new({}, {
              prompt_title = "Harpoon",
              finder = require("telescope.finders").new_table({
                  results = file_paths,
              }),
              previewer = conf.file_previewer({}),
              sorter = conf.generic_sorter({}),
          }):find()
      end

      vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end)
    '';

    keymaps = [{
      key = "<leader>a";
      lua = true;
      action = "require('harpoon'):list():add()";
      mode = "n";
    }];
  };
}
