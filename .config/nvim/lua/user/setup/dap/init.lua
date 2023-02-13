local function config()
  local dap = require('dap')
  local dapui = require('dapui')

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close

  -- signs
  vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'GruvboxRedSign' })

  -- adapters/configs
  require('user.setup.dap.lldb')
end

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    opts = {
      controls = {
        enabled = false, -- don't override winbar
      },
    },
  },
  config = config,
  -- stylua: ignore
  keys = {
    { '<leader>dl', function() require('dap').run_last() end },
    { '<leader>db', function() require('dap').toggle_breakpoint() end },
    { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end },
    { '<leader>dR', function() require('dap').clear_breakpoints() end },
    { '<leader>dc', function() require('dap').continue() end },
    { '<leader>dC', function() require('dap').run_to_cursor() end },
    { '<leader>dsi', function() require('dap').step_into() end },
    { '<leader>dso', function() require('dap').step_over() end },
    { '<leader>dsO', function() require('dap').step_out() end },
  },
}
