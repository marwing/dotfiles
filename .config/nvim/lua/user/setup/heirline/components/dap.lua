return {
  condition = function()
    local dap = package.loaded.dap
    local dapui = package.loaded.dapui
    return dap and dapui and dap.session()
  end,
  -- let's see if this api is stable
  provider = function()
    require('dapui.controls').controls()
  end,
}
