return {
  -- Lua port of tpope/vim-surround
  'kylechui/nvim-surround',
  event = 'VeryLazy',
  config = function()
    require('nvim-surround').setup {
      -- Configuration here, or leave empty to use defaults
    }
  end,
}
