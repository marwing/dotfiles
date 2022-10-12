-- more or less direct port of vim-airline's vimtex component
-- see https://github.com/vim-airline/vim-airline/blob/master/autoload/airline/extensions/vimtex.vim

local icons = require('user.setup.heirline.icons')

return {
  condition = function(self)
    self.vimtex = vim.b.vimtex
    return self.vimtex ~= nil
  end,
  init = function(self)
    self.status = {
      main = nil,
      sub_local = nil,
      sub_main = nil,
      viewer = nil,
      continuous = nil,
      compiled = nil,
    }

    local vimtex = self.vimtex
    local vt_local = vim.b.vimtex_local

    if not vt_local then
      self.status.main = true
    else
      if vt_local.active == 1 then
        self.status.sub_local = true
      else
        self.status.sub_main = true
      end
    end

    if vimtex.viewer.xwinid then
      self.status.viewer = true
    end

    if vimtex.compiler then
      if vimtex.compiler.is_running and vim.api.nvim_eval('b:vimtex.compiler.is_running()') then
        if vimtex.compiler.continuous == 1 then
          self.status.continuous = true
        else
          self.status.compiled = true
        end
      end
    end
  end,
  provider = function(self)
    local status = ''

    for key, val in pairs(self.status) do
      if val then
        status = status .. icons.vimtex[key]
      end
    end

    return '{' .. status .. '}'
  end,
}
