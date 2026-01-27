return {
  {
    'olimorris/codecompanion.nvim',
    version = '^18.0.0',
    -- config = function()
    -- vim.api.nvim_set_keymap({ 'n', 'v' }, '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
    -- vim.keymap.set({ 'n', 'v' }, '<C-a>', ':CodeCompanionActions<CR>', { noremap = true, silent = true })
    -- end,
    dependencies = {
      { 'github/copilot.vim' },                       -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim',          branch = 'master' }, -- for curl, log and async functions
      { 'nvim-treesitter/nvim-treesitter' },
      {
        'OXY2DEV/markview.nvim',
        lazy = false,
        opts = {
          preview = {
            filetypes = { 'markdown', 'codecompanion' },
            ignore_buftypes = {},
          },
        },
      },
      {
        'HakonHarnes/img-clip.nvim',
        opts = {
          filetypes = {
            codecompanion = {
              prompt_for_file_name = false,
              template = '[Image]($FILE_PATH)',
              use_absolute_path = true,
            },
          },
        },
      },
    },
    -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
    opts = {
      adapters = {
        acp = {
          claude_code = function()
            return require('codecompanion.adapters').extend('claude_code', {
              env = {
                ANTHROPIC_API_KEY = vim.env.ANTHROPIC_API_KEY,
              },
              -- defaults = {
              --   ---@param self CodeCompanion.ACPAdapter
              --   ---@return string
              -- },
            })
          end,
        },
      },
      display = {
        action_palette = {
          width = 95,
          height = 10,
          prompt = 'Prompt ',                -- Prompt used for interactive LLM calls
          provider = 'telescope',            -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
          opts = {
            show_preset_actions = true,      -- Show the preset actions in the action palette?
            show_preset_prompts = true,      -- Show the preset prompts in the action palette?
            title = 'CodeCompanion actions', -- The title of the action palette
          },
        },
      },
      log_level = 'DEBUG', -- or "TRACE"
    },
  },
}
