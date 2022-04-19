-- more or less direct port of vim-airline's vimtex component
-- see https://github.com/vim-airline/vim-airline/blob/master/autoload/airline/extensions/vimtex.vim

local M = require('lualine.component'):extend()

local default_options = {
  symbols = {
    main = "",
    sub_local = "l",
    sub_main = "m",
    viewer = "v",
    continuous = "c",
    compiled = "c:",
  }
}

function M:init(options)
  M.super.init(self, options)
  self.options = vim.tbl_deep_extend('keep', self.options or {}, default_options)
end

local function build_status(symbols)
  local status = ''
  local vimtex = vim.b.vimtex
  local vt_local = vim.b.vimtex_local

  if vimtex then
    if not vt_local then
      status = status .. symbols.main
    else
      if vt_local.active == 1 then
        status = status .. symbols.sub_local
      else
        status = status .. symbols.sub_main
      end
    end

    if vimtex.viewer.xwinid then
      status = status .. symbols.viewer
    end

    if vimtex.compiler then
      if vimtex.compiler.is_running and vim.api.nvim_eval("b:vimtex.compiler.is_running()") then
        if vimtex.compiler.continuous == 1 then
          status = status .. symbols.continuous
        else
          status = status .. symbols.compiled
        end
      end
    end
  end

  return status
end

function M:update_status()
  local status = build_status(self.options.symbols)

  if status and status ~= '' then
    status = '{' .. status
    status = status .. '}'
  end

  return status
end

return M
