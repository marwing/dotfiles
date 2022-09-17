-- Keep undo history across sessions, by storing in file.
vim.o.undofile = true

-- set tabwith to 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- automatically expand tabs to spaces
vim.o.expandtab = true

-- set hybrid line numbers
vim.o.number = true
vim.o.relativenumber = true

-- spell checking default language
vim.o.spelllang = 'de_20'

-- more natural splits
vim.o.splitbelow = true
vim.o.splitright = true

-- wrap at words, not letters
vim.o.wrap = true
vim.o.linebreak = true

vim.o.cmdheight = 0
vim.o.showmode = false
vim.o.clipboard = 'unnamedplus'
vim.o.mouse = ''

vim.o.signcolumn = 'yes'
vim.o.foldcolumn = 'auto'

vim.o.colorcolumn = '+0'

vim.o.scrolloff = 5

vim.o.list = true

-- enable truecolor support if terminal claims to support it
vim.o.termguicolors = vim.env.COLORTERM == 'truecolor'

-- keep some paths out of shada file
vim.opt.shada:append { 'r/mnt', 'r/run/media', 'r/run/user', 'r/tmp' }

-- don't insert comments around comments with o/O
-- the autocmd is necessary because some ftplugins override this
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('user_fo_update', { clear = true }),
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove('o')
  end,
})
