-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--

local function setup_ruby_configuration(dap)
  local base_config = {
    type = "ruby",
    request = "attach",
    options = { source_filetype = "ruby" },
    error_on_failure = true,
    localfs = true,
  }
  local run_config = vim.tbl_extend("force", base_config, { waiting = 1000, random_port = true })
  local function extend_base_config(config)
    return vim.tbl_extend("force", base_config, config)
  end
  local function extend_run_config(config)
    return vim.tbl_extend("force", run_config, config)
  end
  dap.configurations.ruby = {
    extend_run_config({
      name = "debug current file",
      command = "bundle",
      args = { "exec", "rdbg", "-c", "--nonstop", "--", "ruby" },
      current_file = true,
    }),
    extend_run_config({
      name = "run rails",
      command = "bundle",
      args = { "exec", "rdbg", "-c", "--nonstop", "--", "rails", "s" },
    }),
    extend_run_config({
      name = "run rspec current file",
      command = "bundle",
      args = { "exec", "rdbg", "-c", "--nonstop", "--", "rspec" },
      current_file = true,
    }),
    extend_run_config({
      name = "run rails test current_file:current_line",
      command = "bundle",
      args = { "exec", "rdbg", "-c", "--nonstop", "--", "rails", "test" },
      current_line = true,
    }),
    extend_run_config({
      name = "run rspec current_file:current_line",
      command = "bundle",
      args = { "exec", "rdbg", "-c", "--nonstop", "--", "rspec" },
      current_line = true,
    }),
    extend_run_config({
      name = "TEST run rspec current_file:current_line",
      command = "bundle",
      args = { "exec", "rdbg", "-c", "--nonstop", "--", "rspec" },
      current_line = true,
      error_on_failure = false,
      stdout_handler = function(chunk)
        print(chunk)
      end,
    }),
    extend_run_config({
      name = "run rspec",
      command = "bundle",
      waiting = 4000,
      args = { "exec", "rdbg", "-c", "--nonstop", "--", "rspec" },
    }),
    extend_run_config({ name = "bin/dev", command = "bin/dev" }),
    extend_base_config({ name = "attach existing (port 38698)", port = 38698, waiting = 0 }),
    extend_base_config({ name = "attach existing (pick port)", waiting = 0 }),
  }
end

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'suketa/nvim-dap-ruby'
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    { '<F1>',           function() require('dap').continue() end,                                            desc = 'Debug: Start/Continue' },
    { '<F2>',           function() require('dap').step_into() end,                                           desc = 'Debug: Step Into' },
    { '<F3>',           function() require('dap').step_over() end,                                           desc = 'Debug: Step Over', },
    { '<F4>',           function() require('dap').step_out() end,                                            desc = 'Debug: Step Out', },
    { '<F13>',          function() require('dap').restart() end,                                             desc = 'Debug: Restart', },
    { '<leader>b',      function() require('dap').toggle_breakpoint() end,                                   desc = 'Debug: Toggle Breakpoint', },
    { '<leader>B',      function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Set Breakpoint', },
    { '<localleader>?', function() require('dapui').eval(nil, { enter = true }) end,                         desc = 'Eval the var under the cursor', },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    { '<F7>',           function() require('dapui').toggle() end,                                            desc = 'Debug: See last session result.', },
  },
  config = function()
    require("dap-ruby").setup()

    local dap_ok, dap = pcall(require, "dap")
    local dap_ui_ok, dapui = pcall(require, "dapui")

    if not (dap_ok and dap_ui_ok) then
      require("notify")("nvim-dap or dap-ui not installed!", "warning") -- nvim-notify is a separate plugin, I recommend it too!
      return
    end

    setup_ruby_configuration(dap)

    --require('mason-nvim-dap').setup {
    ---- Makes a best effort to setup the various debuggers with
    ---- reasonable debug configurations
    --automatic_installation = true,

    ---- You can provide additional configuration to the handlers,
    ---- see mason-nvim-dap README for more information
    --handlers = {},

    ---- You'll need to check that you have the required things installed
    ---- online, please don't ask me how to install them :)
    --ensure_installed = {
    ---- Update this to ensure that you have the debuggers for the langs you want
    --'delve',
    --},
    --}

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      -- icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      -- controls = {
      --  icons = {
      --    pause = '⏸',
      --    play = '▶',
      --    step_into = '⏎',
      --    step_over = '⏭',
      --    step_out = '⏮',
      --    step_back = 'b',
      --    run_last = '▶▶',
      --    terminate = '⏹',
      --    disconnect = '⏏',
      --  },
      -- },
    }

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '🐞', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
        or { Breakpoint = '🐞', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
}
