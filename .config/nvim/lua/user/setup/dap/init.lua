local map = require('user.utils').keymap('<leader>d', 'n')

local dap = require('dap')
local dapui = require('dapui')

dapui.setup {
  controls = {
    enabled = false, -- don't override winbar
  },
}

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

local function set_conditional_breakpoint()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end

-- keymaps
map('l', dap.run_last)
map('b', dap.toggle_breakpoint)
map('B', set_conditional_breakpoint)
map('R', dap.clear_breakpoints)
map('c', dap.continue)
map('C', dap.run_to_cursor)
map('si', dap.step_into)
map('so', dap.step_over)
map('sO', dap.step_out)

-- signs
vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'GruvboxRedSign' })

-- adapters/configs
require('user.setup.dap.lldb')
