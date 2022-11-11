local conditions = require('heirline.conditions')

local colors = require('user.setup.heirline.colors')
local icons = require('user.setup.heirline.icons')

local function git_diff_component(s)
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

local long = {
  { -- branch
    provider = function(self)
      local ret = icons.git.branch
      if self.status_dict.head ~= '' then
        ret = ret .. ' ' .. self.status_dict.head
      end
      return ret
    end,
    hl = {
      bold = true,
    },
  },
  git_diff_component('added'),
  git_diff_component('changed'),
  git_diff_component('removed'),
}

local short = {
  {
    provider = icons.git.branch,
    hl = {
      bold = true,
    },
  },
  git_diff_component('added'),
  git_diff_component('changed'),
  git_diff_component('removed'),
}

local git = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
  end,

  flexible = 2,
  long,
  short,
}

return git
