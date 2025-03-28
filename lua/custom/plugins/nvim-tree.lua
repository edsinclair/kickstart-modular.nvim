-- nvim-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-tree/nvim-tree.lua

return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('nvim-tree').setup {
      actions = {
        open_file = {
          resize_window = false,
        },
      },
    }
  end,
  keys = {
    { '\\', function() vim.cmd [[NvimTreeToggle]] end, mode = { 'n', 't' }, desc = 'Toggle nvim-tree' },
    { '|', function() vim.cmd [[NvimTreeFindFile]] end, desc = 'Show current file in nvim-tree' }
  }
}
