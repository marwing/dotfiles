" vim:foldmethod=marker

" ======================= PLUGINS ======================= {{{1
if !filereadable(expand('~/.config/nvim/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent call mkdir(expand("~/.config/nvim/autoload/"), "p")
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

" Vim-Plug Setup {{{2
call plug#begin(stdpath("cache") . '/plugged')
    Plug 'lewis6991/impatient.nvim'

    " Dependencies
    Plug 'ryanoasis/vim-devicons'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'stevearc/dressing.nvim'
    Plug 'MunifTanjim/nui.nvim'
    Plug 'onsails/lspkind.nvim'

    " Themes
    Plug 'gruvbox-community/gruvbox'

    " Syntax
    Plug 'chrisbra/Colorizer'
    Plug 'terminalnode/sway-vim-syntax'
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'MaxMEllon/vim-jsx-pretty'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " Statusline
    Plug 'nvim-lualine/lualine.nvim'

    " Startup Screen
    Plug 'mhinz/vim-startify'

    " IDE?
    Plug 'editorconfig/editorconfig-vim'
    Plug 'jiangmiao/auto-pairs'
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
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'p00f/clangd_extensions.nvim'
    Plug 'j-hui/fidget.nvim'
    Plug 'simrat39/rust-tools.nvim'

    " Telescope
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'nvim-telescope/telescope-ui-select.nvim'
    Plug 'gbrlsnchs/telescope-lsp-handlers.nvim'

    " LaTeX
    Plug 'lervag/vimtex'
    " Markdown
    Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
    Plug 'dhruvasagar/vim-table-mode'

    " TMUX integration
    " Plug 'edkolev/tmuxline.vim'
call plug#end()

" load impatient before every other lua plugin
lua pcall(require, "impatient")

" lua plugins {{{2
lua <<EOF
require('user.setup.lsp')
require('user.setup.diagnostic')
require('user.setup.nvim-cmp')
require('user.setup.luasnip')
require('user.setup.telescope')
require('user.setup.dressing')
require('user.setup.lualine')
require('user.setup.nvim-treesitter')
require('user.setup.zen-mode')
require('user.setup.twilight')
require('user.setup.gitsigns')
require('user.setup.Comment')
require('user.setup.neo-tree')
EOF

" Tmuxline Setup {{{2
" let g:tmuxline_preset = 'full'
" let g:tmuxline_preset = 'powerline'

" vim-cmake Setup {{{2
let g:cmake_build_dir_location = "build"
let g:cmake_link_compile_commands = 1
let g:cmake_generate_options = ["-GNinja"]
nmap cb <Plug>(CMakeBuild)
nmap <silent>cr :CMakeSwitch Release<CR>
nmap <silent>cd :CMakeSwitch Debug<CR>
nmap cq <Plug>(CMakeClose)

" vimtex setup {{{2
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode = 0
let g:vimtex_compiler_latexmk = {
  \ 'build_dir' : 'dist',
  \}
autocmd FileType tex set textwidth=80

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

set shada+=r/mnt
set shada+=r/run/media

" How fast some features update (some airline plugins, tagbar, ...)
set updatetime=300

" Colorscheme
let g:gruvbox_italic = v:true
silent! colorscheme gruvbox

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

" format JSON using jq
autocmd FileType json map <silent> <A-S-f> :silent %!jq .<CR>

autocmd FileType markdown set conceallevel=2
