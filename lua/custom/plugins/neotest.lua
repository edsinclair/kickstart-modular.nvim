return {
  "nvim-neotest/neotest",
  lazy = true,
  dependencies = {
    "edsinclair/neotest-rspec",
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter"
  },
  config = function()
    require("neotest").setup({
      log_level = vim.log.levels.DEBUG,
      adapters = {
        require("neotest-rspec")({
          rspec_cmd = function()
            return vim.tbl_flatten({
              "bundle",
              "exec",
              "rdbg",
              "--nonstop",
              "-c",
              "--",
              "rspec",
            })
          end,
        })
      },
      icons = {
        expanded = "",
        child_prefix = "",
        child_indent = "",
        final_child_prefix = "",
        non_collapsible = "",
        collapsed = "",
        passed = "",
        running = "",
        failed = "",
        unknown = "",
      }
    })
  end,
  keys = {
    { '<leader>tt', function() require("neotest").run.run(vim.fn.expand("%")) end,   mode = 'n', desc = 'Run rspec on current file' },
    { '<leader>ti', function() require("neotest").run.run() end,                     mode = 'n', desc = 'Run rspec on current example' },
    { '<leader>tS', function() require("neotest").run.run(vim.fn.getcwd()) end,      mode = 'n', desc = 'Run rspec on entire suite' },
    { '<leader>td', function() require("neotest").run.run({ strategy = "dap" }) end, mode = 'n', desc = 'Debug' },
  }
}
