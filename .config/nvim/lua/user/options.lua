-- Keep undo history across sessions, by storing in file.
vim.opt.undofile = true

-- set tabwith to 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- automatically expand tabs to spaces
vim.opt.expandtab = true

-- set hybrid line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- spell checking default language
vim.opt.spelllang = 'de_20'

-- more natural splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- wrap at words, not letters
vim.opt.wrap = true
vim.opt.linebreak = true

vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'

vim.opt.signcolumn = 'yes'

vim.opt.colorcolumn = '+0'

vim.opt.scrolloff = 5

vim.opt.list = true

-- enable truecolor support if terminal claims to support it
vim.opt.termguicolors = vim.env.COLORTERM == 'truecolor'

-- keep some paths out of shada file
vim.opt.shada:append({ 'r/mnt', 'r/run/media', 'r/run/user', 'r/tmp' })

-- How fast some features update (some airline plugins, tagbar, ...)
vim.opt.updatetime = 300
