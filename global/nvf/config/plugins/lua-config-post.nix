{
  programs.nvf.settings.vim.luaConfigPost = ''
    vim.g.rustaceanvim.server.default_settings = {['rust-analyzer'] = {
      inlayHints = {
        chainingHints = {
          enable = true,
          maxLength = 20,
          maxItems = 5,
        },
        typeHints = {
          enable = true,
        },
        parameterHints = {
          enable = true,
        },
      },
    }}

    require('illuminate').configure({providers = {'lsp'}})

    vim.api.nvim_create_user_command("Wnf", function()
        if vim.b.disableFormatSave then
          return
        end

        vim.b.disableFormatSave = true
        vim.api.nvim_command("write")
        vim.b.disableFormatSave = false
      end,
      {}
    )

    vim.keymap.del("n", "vl")
    vim.keymap.del("v", "l")
  '';
}
