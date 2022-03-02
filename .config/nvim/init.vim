" vim:foldmethod=marker

" ======================= PLUGINS ======================= {{{
if !filereadable(expand('~/.config/nvim/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent call mkdir(expand("~/.config/nvim/autoload/"), "p")
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

" Vim-Plug Setup {{{
call plug#begin(stdpath("cache") . '/plugged')
    " Themes
    Plug 'morhetz/gruvbox'

    " Syntax
    Plug 'chrisbra/Colorizer'
    Plug 'terminalnode/sway-vim-syntax'
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'MaxMEllon/vim-jsx-pretty'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " Statusline
    Plug 'vim-airline/vim-airline'

    " Startup Screen
    Plug 'mhinz/vim-startify'

    " IDE?
    Plug 'editorconfig/editorconfig-vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/fzf'
    Plug 'majutsushi/tagbar'
    Plug 'ryanoasis/vim-devicons'
    Plug 'scrooloose/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-commentary'

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
    Plug 'vim-denops/denops.vim'
    Plug 'Shougo/ddc.vim'

    Plug 'Shougo/ddc-matcher_head'
    Plug 'Shougo/ddc-sorter_rank'

    Plug 'Shougo/ddc-around'
    Plug 'delphinus/ddc-treesitter'
    Plug 'LumaKernel/ddc-file'
    Plug 'Shougo/ddc-nvim-lsp'
    Plug 'Shougo/neco-vim'

    " Snippets
    Plug 'Shougo/neosnippet.vim'
    Plug 'Shougo/neosnippet-snippets'
    Plug 'honza/vim-snippets'

    " nvim-lsp
    Plug 'neovim/nvim-lspconfig'
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
" }}}

" ddc configuration {{{
call ddc#custom#patch_global({
\   'sources': ['nvim-lsp', 'neosnippet', 'file', 'treesitter', 'around'],
\   'smartCsae': v:true,
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
\   },
\   'sourceParams': {
\     'around': {'maxSize': 500},
\   },
\ })

call ddc#custom#patch_filetype(['vim'], 'sources', ['necovim', 'neosnippet', 'file', 'treesitter', 'around'])

call ddc#enable()
" }}}

" LSP Client Setup {{{
lua <<EOF
-- Mappings {{{
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
-- }}}

-- nvim-lspconfig {{{
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

local servers = { "cmake", "pylsp", "pyright", "texlab", "tsserver" }
for _, server in ipairs(servers) do
  lspconfig[server].setup{
    on_attach = on_attach
  }
end
-- }}}

-- diagnostic {{{
vim.diagnostic.config({
  update_in_insert = true,
  severity_sort = true,
  virtual_text = { source = "always" },
  float = { source = "always" },
})
-- }}}

-- lsp_signature {{{
require'lsp_signature'.setup{}
-- }}}
EOF
" }}}

" Airline Setup {{{
let g:airline_extensions = ["branch", "fugitiveline", "hunks", "nvimlsp", "obsession", "quickfix", "searchcount", "tabline", "tagbar", "term", "vimcmake", "vimtex", "whitespace", "wordcount"]
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#vimtex#wordcount = 1
" }}}

" Tmuxline Setup {{{
" let g:tmuxline_preset = 'full'
" let g:tmuxline_preset = 'powerline'
" }}}

" Treesitter Setup {{{
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = { "cmake", "vim", "latex" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
" }}}

" Zen Mode Setup {{{
lua << EOF
  require("zen-mode").setup {
    plugins = {
      tmux = { enabled = true },
    },
  }
EOF
" }}}

" Twilight Setup {{{
lua << EOF
  require("twilight").setup {}
EOF
" }}}

" Neosnippets Setup {{{
let g:neosnippet#enable_complete_done = 1
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory=stdpath("cache") . '/plugged/vim-snippets/snippets'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" }}}

" vim-cmake Setup {{{
let g:cmake_build_dir_location = "build"
let g:cmake_link_compile_commands = 1
let g:cmake_generate_options = ["-GNinja"]
nmap cb <Plug>(CMakeBuild)
nmap <silent>cr :CMakeSwitch Release<CR>
nmap <silent>cd :CMakeSwitch Debug<CR>
nmap cq <Plug>(CMakeClose)
" }}}

" vim-gitgutter Setup {{{
let g:gitgutter_signs = 0
" }}}

" vimtex setup {{{
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode = 0
let g:vimtex_compiler_latexmk = {
  \ 'build_dir' : 'dist',
  \}
autocmd FileType tex set textwidth=80
" }}}

" vim-commentary Setup {{{
" I rarely use folds and vim-commentary doesn't do multiline anyway
autocmd FileType c,cpp setlocal commentstring=//\ %s
" }}}

" EditorConfig Setup {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']
" }}}

" Startify Setup {{{
let g:startify_commands = [
\   { 'up': ['Update Plugins', ':PlugUpdate'] },
\ ]

let g:startify_bookmarks = [
\   { 'c': '~/.config/nvim/init.vim' },
\   { 'g': '~/.config/git/ignore' },
\ ]
" }}}

" NERDTree Setup {{{
let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1
let g:NERDTreeLimitedSyntax = 1

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

nmap <silent> <F7> :NERDTreeToggleVCS<CR>
imap <silent> <F7> <C-o><F7>
" }}}
" }}}

" ================ Persistent Undo ================== {{{
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  " neovim automatically creates last (in this case only) path in undodir
  let &undodir=stdpath("data") . "/undo"
  set undofile
endif
" }}}

" ======================= VIM ======================= {{{
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
set colorcolumn=80

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
" }}}

" ====================== KEYBINDINGS ====================== {{{
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

nmap <silent> <C-p> :FZF<CR>

map <silent> <C-s> :Commentary<CR>
imap <C-s> <c-o><C-s>

" format JSON using jq
autocmd FileType json map <silent> <A-S-f> :silent %!jq .<CR>
" }}}
