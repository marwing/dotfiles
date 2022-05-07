local ok, lualine = pcall(require, "lualine")
if not ok then
  return
end

local function gitsigns_diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

lualine.setup {
  sections = {
    lualine_a = { 'mode', 'spell' },
    lualine_b = { 'branch', { 'diff', source = gitsigns_diff_source }, 'diagnostics' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'filetype' },
    lualine_y = { 'vimtex', 'encoding_fileformat', 'searchcount' },
    lualine_z = { 'obsession', 'wordcount', 'fileprogress' }
  },
  extensions = { 'fugitive', 'my-neo-tree', 'quickfix', 'vimcmake' },
}
