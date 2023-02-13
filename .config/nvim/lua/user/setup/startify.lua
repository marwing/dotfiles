local function config()
  local function setup()
    vim.g.startify_commands = {
      { up = { 'Update Plugins', 'PackerSync' } },
    }

    vim.g.startify_bookmarks = {
      { c = '~/.config/nvim/init.lua' },
      { g = '~/.config/git/ignore' },
    }

    vim.cmd([[
function! StartifyEntryFormat()
  return 'luaeval("require\"user.setup.startify\".entry_format(_A)", entry_path)'
endfunction
]])
  end

  local function entry_format(path)
    return require('nvim-web-devicons').get_icon(path, nil, { default = true }) .. ' ' .. path
  end

  return {
    setup = setup,
    entry_format = entry_format,
  }
end

return {
  -- startup screen
  'mhinz/vim-startify',
  requires = 'kyazdani42/nvim-web-devicons',
  init = function()
    require('user.setup.startify').setup()
  end,
  enabled = false,
}
