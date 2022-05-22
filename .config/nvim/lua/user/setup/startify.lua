vim.g.startify_commands = {
  { up = { 'Update Plugins', 'PackerSync' } },
}

vim.g.startify_bookmarks = {
  { c = '~/.config/nvim/init.lua' },
  { g = '~/.config/git/ignore' },
}

function StartifyEntryFormat(path)
  return require('nvim-web-devicons').get_icon(path, nil, { default = true }) .. " " .. path
end

vim.cmd [[
function! StartifyEntryFormat()
  return 'luaeval("StartifyEntryFormat(_A)", entry_path)'
endfunction
]]
