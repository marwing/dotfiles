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
    Plug 'Shougo/ddc.vim'

    Plug 'Shougo/ddc-matcher_head'
    Plug 'Shougo/ddc-sorter_rank'

    Plug 'Shougo/ddc-around'
    Plug 'delphinus/ddc-treesitter'
    Plug 'LumaKernel/ddc-file'
    Plug 'gamoutatsumi/ddc-emoji'
    Plug 'Shougo/ddc-nvim-lsp'
    Plug 'Shougo/neco-vim'
    Plug 'matsui54/ddc-dictionary'

    " Snippets
    Plug 'Shougo/neosnippet.vim'
    Plug 'Shougo/neosnippet-snippets'
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

" ddc configuration {{{2
call ddc#custom#patch_global({
\   'sources': ['nvim-lsp', 'neosnippet', 'emoji', 'file', 'treesitter', 'around', 'dictionary'],
\   'smartCase': v:true,
\   'keywordPattern': '[a-zA-Z_:]\w*',
\
\   'sourceOptions': {
\     '_': {
\       'matchers': ['matcher_head'],
\       'sorters': ['sorter_rank'],
\     },
\     'around': {
\       'mark': 'A',
\     },
\     'treesitter': {
\       'mark': 'TS',
\     },
\     'file': {
\       'mark': 'F',
\       'isVolatile': v:true,
\       'forceCompletionPattern': '\S/\S*',
\     },
\     'emoji': {
\       'mark': 'emoji',
\       'matchers': ['emoji'],
\       'sorters': [],
\     },
\     'nvim-lsp': {
\       'mark': 'lsp',
\       'forceCompletionPattern': '\.\w*|:\w*|->\w*',
\     },
\     'necovim': {
\       'mark': 'vim',
\     },
\     'neosnippet': {
\       'mark': 'NS',
\       'dup': v:true,
\     },
\     'dictionary': {
\       'mark': 'D',
\     },
\   },
\   'sourceParams': {
\     'around': {'maxSize': 500},
\     'dictionary': {'dictPaths': ['/usr/share/dict/german']},
\   },
\ })

call ddc#custom#patch_filetype(['vim'], 'sources', ['necovim', 'neosnippet', 'file', 'treesitter', 'around', 'dictionary'])

call ddc#enable()

" LSP Client Setup {{{2
lua <<EOF
-- Mappings {{{3
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', 'dD', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', 'dq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'KK', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<A-S-f>', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'Kk', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  if client.name == "clangd" then
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F12>', '<cmd>ClangdSwitchSourceHeader<CR>', opts)
  end
end

-- nvim-lspconfig {{{3
local lspconfig = require'lspconfig'

require("clangd_extensions").setup {
    server = {
        cmd = { "clangd", "-query-driver=/usr/**/arm-none-eabi*", "--completion-style=detailed", "--malloc-trim", "--enable-config", "--use-dirty-headers" },
        on_attach = on_attach
    },
    extensions = {
        autoSetHints = false,
    }
}

local servers = { "cmake", "pylsp", "pyright", "rust_analyzer", "texlab", "tsserver" }
for _, server in ipairs(servers) do
  lspconfig[server].setup{
    on_attach = on_attach
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

" Neosnippets Setup {{{2
" let g:neosnippet#enable_complete_done = 1
" let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory=stdpath("cache") . '/plugged/vim-snippets/snippets'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

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
