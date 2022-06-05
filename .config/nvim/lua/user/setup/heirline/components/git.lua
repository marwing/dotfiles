local conditions = require('heirline.conditions')
local icons = require('user.setup.heirline.icons')
local colors = require('user.setup.heirline.colors')

local function git_component(s)
  return {
    condition = function(self)
      return self.status_dict[s] ~= nil and self.status_dict[s] > 0
    end,
    provider = function(self)
      return ' ' .. icons.git[s] .. self.status_dict[s]
    end,
    hl = { fg = colors.git[s] },
  }
end

local git = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = --
      self.status_dict.added ~= 0 --
      or self.status_dict.changed ~= 0 --
      or self.status_dict.removed ~= 0
  end,
  { -- branch
    provider = function(self)
      return ' ' .. icons.git.branch .. ' ' .. self.status_dict.head
    end,
  },
  -- {
  --   condition = function(self)
  --     return self.has_changes
  --   end,
  --   provider = ' ' .. icons.seperators.right,
  -- },
  git_component('added'),
  git_component('changed'),
  git_component('removed'),
}

return git
