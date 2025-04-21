return {
  "nvim-neotest/neotest",
  lazy = true,
  dependencies = {
    "edsinclair/neotest-rspec",
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter"
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      log_level = vim.log.levels.DEBUG,
      status = { virtual_text = true },
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
      floating = {
        border = "rounded",
        max_height = 0.6,
        max_width = 0.6,
        options = {}
      },
      jump = {
        enabled = true
      },
      output = {
        enabled = true,
        open_on_run = true
      },
      output_panel = {
        enabled = true,
        open = "botright split | resize 15"
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
      },
      consumers = {
        -- always_open_output = function(client)
        --   local async = require("neotest.async")
        --
        --   client.listeners.results = function(adapter_id, results)
        --     local file_path = async.fn.expand("%:p")
        --     local row = async.fn.getpos(".")[2] - 1
        --     local position = client:get_nearest(file_path, row, {})
        --     if not position then
        --       return
        --     end
        --     local pos_id = position:data().id
        --     if not results[pos_id] then
        --       return
        --     end
        --     neotest.output.open({ position_id = pos_id, adapter = adapter_id })
        --   end
        -- end,
      },
    })
  end,
  keys = {
    { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end,                      desc = "Run File (Neotest)" },
    { "<leader>tS", function() require("neotest").run.run(vim.fn.getcwd()) end,                         desc = "Run All Test Files (Neotest)" },
    { "<leader>ti", function() require("neotest").run.run() end,                                        desc = "Run Nearest (Neotest)" },
    { "<leader>tl", function() require("neotest").run.run_last() end,                                   desc = "Run Last (Neotest)" },
    { "<leader>ts", function() require("neotest").summary.toggle() end,                                 desc = "Toggle Summary (Neotest)" },
    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end,                            desc = "Toggle Output Panel (Neotest)" },
    { "<leader>tx", function() require("neotest").run.stop() end,                                       desc = "Stop (Neotest)" },
    { "<leader>tn", function() require("neotest").jump.next({ status = "failed" }) end,                 desc = "Jump to next failed test (Neotest)" },
    { "<leader>tp", function() require("neotest").jump.prev({ status = "failed" }) end,                 desc = "Jump to previous failed test (Neotest)" },
    { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end,                    desc = "Debug" },
  }
}
