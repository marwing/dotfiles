local dap = require('dap')

return {
  condition = function()
    return
    -- dap.configurations[vim.bo.filetype] ~= nil or
    dap.session() ~= nil
  end,
  -- let's see if this api is stable
  provider = require('dapui').controls,
}
