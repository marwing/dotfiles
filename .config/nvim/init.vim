" vim:foldmethod=marker

" ======================= PLUGINS ======================= {{{1
if !filereadable(expand('~/.config/nvim/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent call mkdir(expand("~/.config/nvim/autoload/"), "p")
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

" Vim-Plug Setup {{{2
call plug#begin(stdpath("cache") . '/plugged')
    " Dependencies
    Plug 'ryanoasis/vim-devicons'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'stevearc/dressing.nvim'
    Plug 'MunifTanjim/nui.nvim'
    Plug 'vim-denops/denops.vim'
    Plug 'onsails/lspkind.nvim'

    " Themes
    Plug 'morhetz/gruvbox'

    " Syntax
    Plug 'chrisbra/Colorizer'
    Plug 'terminalnode/sway-vim-syntax'
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'MaxMEllon/vim-jsx-pretty'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " Statusline
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'arkav/lualine-lsp-progress'

    " Startup Screen
    Plug 'mhinz/vim-startify'

    " IDE?
    Plug 'editorconfig/editorconfig-vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'majutsushi/tagbar'
    Plug 'nvim-neo-tree/neo-tree.nvim'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'numToStr/Comment.nvim'

    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'shumphrey/fugitive-gitlab.vim'
    Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-obsession'
    Plug 'cdelledonne/vim-cmake'
    Plug 'folke/zen-mode.nvim'
    Plug 'folke/twilight.nvim'

    " Autocompletition
    Plug 'hrsh7th/nvim-cmp'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-path'
    Plug 'ray-x/cmp-treesitter'
    Plug 'hrsh7th/cmp-buffer'
    " Plug 'uga-rosa/cmp-dictionary'
    Plug 'hrsh7th/cmp-emoji'

    " Snippets
    Plug 'L3MON4D3/LuaSnip'
    Plug 'honza/vim-snippets'

    " nvim-lsp
    Plug 'neovim/nvim-lspconfig'
    Plug 'gfanto/fzf-lsp.nvim'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'p00f/clangd_extensions.nvim'

    " LaTeX
    Plug 'lervag/vimtex'
    " Markdown
    Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
    Plug 'dhruvasagar/vim-table-mode'

    " TMUX integration
    " Plug 'edkolev/tmuxline.vim'
call plug#end()

" nvim-cmp {{{2
lua <<EOF
local cmp = require'cmp'

vim.opt.completeopt = {"menu", "menuone", "noselect"}

cmp.setup {
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'treesitter' },
    { name = 'buffer' },
    -- { name = 'dictionary' },
    { name = 'emoji' },
  },
  experimental = {
    ghost_text = true,
  },
  formatting = {
    format = require('lspkind').cmp_format({
      mode = "symbol_text",
      menu = ({
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        nvim_lsp = "[LSP]",
        path = "[Path]",
        treesitter = "[TS]",
        buffer = "[Buffer]",
        dictionary = "[Dict]",
        emoji = "[Emoji]",
      })
    }),
  },
}

-- require'cmp_dictionary'.setup {
--   dic = {
--     ["*"] = { "/usr/share/dict/german", "/usr/share/dict/words" }
--   }
-- }
EOF

" LuaSnip Setup {{{2
lua <<EOF
local ls = require'luasnip'

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
}
require("luasnip.loaders.from_snipmate").load()
ls.filetype_extend("all", { "_" })

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, {silent = true})

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, {silent = true})

vim.keymap.set({ "i", "s" }, "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, {silent = true})
EOF

" LSP Client Setup {{{2
lua <<EOF
-- Mappings {{{3
vim.keymap.set('n', 'dD', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', 'dq', vim.diagnostic.setloclist)

local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

  vim.keymap.set('n', 'KK', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

  vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<A-S-f>', vim.lsp.buf.formatting, opts)
  vim.keymap.set('n', 'Kk', vim.lsp.buf.code_action, opts)

  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>wl', function() vim.pretty_print(vim.lsp.buf.list_workspace_folders()) end, opts)

  if client.name == "clangd" then
    vim.keymap.set('n', '<F12>', '<cmd>ClangdSwitchSourceHeader<CR>', opts)
  end
end

-- nvim-lspconfig {{{3
local lspconfig = require'lspconfig'

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require("clangd_extensions").setup {
    server = {
        cmd = { "clangd", "-query-driver=/usr/**/arm-none-eabi*", "--completion-style=detailed", "--malloc-trim", "--enable-config", "--use-dirty-headers" },
        on_attach = on_attach,
        capabilities = capabilities,
    },
    extensions = {
        autoSetHints = false,
    }
}

local servers = { "cmake", "pylsp", "pyright", "rust_analyzer", "texlab", "tsserver" }
for _, server in ipairs(servers) do
  lspconfig[server].setup{
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- sumneko_lua {{{4
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- diagnostic {{{3
vim.diagnostic.config({
  update_in_insert = true,
  severity_sort = true,
  virtual_text = { source = "always" },
  float = { source = "always" },
})

-- lsp_signature {{{3
require'lsp_signature'.setup{}

-- fzf_lsp {{{3
require'fzf_lsp'.setup()
-- 3}}}
EOF

" Lualine Setup {{{2
lua <<EOF
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

require'lualine'.setup {
  sections = {
    lualine_a = { 'mode', 'spell' },
    lualine_b = { 'branch', {'diff', source = gitsigns_diff_source}, 'diagnostics' },
    lualine_c = { { 'filename', path = 1 }, 'lsp_progress' },
    lualine_x = { 'filetype' },
    lualine_y = { 'vimtex', 'encoding_fileformat', 'searchcount' },
    lualine_z = { 'obsession', 'wordcount', 'fileprogress' }
  },
  extensions = { 'fugitive', 'neo-tree', 'quickfix', 'vimcmake' },
}
EOF

" Tmuxline Setup {{{2
" let g:tmuxline_preset = 'full'
" let g:tmuxline_preset = 'powerline'

" Treesitter Setup {{{2
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    disable = { "cmake", "vim", "latex" },
    additional_vim_regex_highlighting = false,
  },
}
EOF

" Zen Mode Setup {{{2
lua << EOF
  require("zen-mode").setup {
    plugins = {
      tmux = { enabled = true },
    },
  }
EOF

" Twilight Setup {{{2
lua << EOF
  require("twilight").setup {}
EOF

" vim-cmake Setup {{{2
let g:cmake_build_dir_location = "build"
let g:cmake_link_compile_commands = 1
let g:cmake_generate_options = ["-GNinja"]
nmap cb <Plug>(CMakeBuild)
nmap <silent>cr :CMakeSwitch Release<CR>
nmap <silent>cd :CMakeSwitch Debug<CR>
nmap cq <Plug>(CMakeClose)

" gitsigns.nvim Setup {{{2
lua <<EOF
require('gitsigns').setup()
EOF

" vimtex setup {{{2
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode = 0
let g:vimtex_compiler_latexmk = {
  \ 'build_dir' : 'dist',
  \}
autocmd FileType tex set textwidth=80

" Comment.nvim Setup {{{2
lua <<EOF
require'Comment'.setup {ignore = '^$'}
EOF

" EditorConfig Setup {{{2
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

" Startify Setup {{{2
let g:startify_commands = [
\   { 'up': ['Update Plugins', ':PlugUpdate'] },
\ ]

let g:startify_bookmarks = [
\   { 'c': '~/.config/nvim/init.vim' },
\   { 'g': '~/.config/git/ignore' },
\ ]

" Neo-tree Setup {{{2
lua <<EOF
require("neo-tree").setup({
  close_if_last_window = true,
  filesystem = {
    filtered_items = {
      visible = true,
    },
    use_libuv_file_watcher = true,
  },
})
EOF

nnoremap <silent> <F7> :Neotree toggle filesystem show reveal<CR>
nnoremap <silent> \s :Neotree float git_status<cr>
nnoremap <silent> \b :Neotree toggle show buffers right<cr>

" ================ Persistent Undo ================== {{{1
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  " neovim automatically creates last (in this case only) path in undodir
  let &undodir=stdpath("data") . "/undo"
  set undofile
endif

" ======================= VIM ======================= {{{1
" use Unicode file encoding by default
set encoding=utf-8

" <TAB> and <DELETE> will behave on spaces as on tabs
set smarttab
" set tabwith to 2
set tabstop=2 softtabstop=2 shiftwidth=2

" automatically expand tabs to spaces
set expandtab

" automatically indent lines where possible
set autoindent

" set relative line numbers
set number relativenumber

" spell checking default language
set spelllang=de_20

" enable syntax highlighting in most files
syntax on

" more natural splits
set splitbelow splitright

" wrap at words, not letters
set wrap linebreak

set noshowmode
set clipboard=unnamedplus

set signcolumn=yes
set cursorline

set autoread
set colorcolumn=+0

set scrolloff=5

" enable truecolor support if terminal claims to support it
if has("termguicolors") && $COLORTERM == "truecolor"
    set termguicolors
endif

" How fast some features update (some airline plugins, tagbar, ...)
set updatetime=300

" Colorscheme
colorscheme gruvbox

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" ====================== KEYBINDINGS ====================== {{{1
let mapleader = ","

" Shortcutting split navigation, saving a keypress:
map <A-h> <C-w>h
map <A-j> <C-w>j
map <A-k> <C-w>k
map <A-l> <C-w>l

" Shortcutting tab navigation
map <leader>n <ESC>:tabprevious<CR>
map <leader>m <ESC>:tabnext<CR>

nmap <silent> <F8> :TagbarToggle<CR>
imap <silent> <F8> <C-o><F8>

nmap <silent> <C-p> :Files<CR>
nmap <silent> <C-A-p> :Buffers<CR>

" format JSON using jq
autocmd FileType json map <silent> <A-S-f> :silent %!jq .<CR>

autocmd FileType markdown set conceallevel=2
