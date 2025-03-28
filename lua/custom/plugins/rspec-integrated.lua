-- Unused
return {
  'melopilosyan/rspec-integrated.nvim',
  lazy = true,
  keys = {
    { '<leader>tt', function() require('rspec').run_current_file() end,    mode = 'n', desc = 'Run rspec on current file' },
    { '<leader>ti', function() require('rspec').run_current_example() end, mode = 'n', desc = 'Run rspec on current example' },
    { '<leader>t.', function() require('rspec').repeat_last_run() end,     mode = 'n', desc = 'Repeat the last test run' },
    { '<leader>td', function() require('rspec').debug() end,               mode = 'n', desc = 'Debug' },
    { '<leader>tS', function() require('rspec').run_suite() end,           mode = 'n', desc = 'Run rspec on entire suite' }
  },
}
