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
    { '<leader>dl',  function() require('dap').run_last() end,                                             desc = 'DAP run_last' },
    { '<leader>db',  function() require('dap').toggle_breakpoint() end,                                    desc = 'DAP toggle_breakpoint'},
    { '<leader>dB',  function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'DAP set_breakpoint'},
    { '<leader>dR',  function() require('dap').clear_breakpoints() end,                                    desc = 'DAP clear_breakpoints'},
    { '<leader>dc',  function() require('dap').continue() end,                                             desc = 'DAP continue'},
    { '<leader>dC',  function() require('dap').run_to_cursor() end,                                        desc = 'DAP run_to_cursor'},
    { '<leader>dsi', function() require('dap').step_into() end,                                            desc = 'DAP step_into'},
    { '<leader>dso', function() require('dap').step_over() end,                                            desc = 'DAP step_over'},
    { '<leader>dsO', function() require('dap').step_out() end,                                             desc = 'DAP step_out'},
  },
}
