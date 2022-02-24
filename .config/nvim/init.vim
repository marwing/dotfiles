" vim:foldmethod=marker

" ======================= PLUGINS ======================= {{{
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ~/.config/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

" Vim-Plug Setup {{{
call plug#begin('~/.config/nvim/plugged')
    "" Async
    " Plug 'skywind3000/asyncrun.vim'

    " Themes
    Plug 'morhetz/gruvbox'

    " Syntax
    Plug 'chrisbra/Colorizer'
    Plug 'terminalnode/sway-vim-syntax'
    " Plug 'sheerun/vim-polyglot' " 80ms
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'MaxMEllon/vim-jsx-pretty'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'folke/twilight.nvim'

    " Statusline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Plug 'itchyny/lightline.vim'

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
    Plug 'wsdjeg/vim-todo'
    Plug 'wsdjeg/FlyGrep.vim'
    Plug 'tpope/vim-obsession'
    Plug 'cdelledonne/vim-cmake'
    Plug 'folke/zen-mode.nvim'

    " Autocompletition
    " Plug 'Shougo/denite.nvim'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/echodoc.vim'

    " Universal
    Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
    " Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' } " Doesn't work on my non-avx laptop
    " Vim
    Plug 'Shougo/neco-vim'
    " Python
    " Plug 'deoplete-plugins/deoplete-jedi'
    " LaTeX
    Plug 'lervag/vimtex'

    " Snippets
    Plug 'Shougo/neosnippet-snippets'
    Plug 'Shougo/neosnippet.vim'
    Plug 'honza/vim-snippets'

    " TMUX integration
    " Plug 'edkolev/tmuxline.vim'
call plug#end()
" }}}

" Deoplete Setup {{{
let g:deoplete#enable_at_startup = 1 " don't start automatically (300ms)
call deoplete#custom#option({
\   'smart_case': v:true,
\ })
call deoplete#custom#option('sources', {
\   '_': ['LanguageClient', 'neosnippet', 'around', 'file'],
\   'vim': ['vim', 'neosnippet'],
\ })
" \   'python': ['jedi', 'neosnippet'],
" \   '_': ['tabnine', 'neosnippet', 'around', 'file'],
call deoplete#custom#source(
    \ '_',
    \ 'disabled_syntaxes', ['Comment', 'String']
\ )

set completeopt+=menuone   " show the popup menu even when there is only 1 match
" set completeopt+=noinsert  " don't insert any text until user chooses a match
set completeopt-=longest   " don't insert the longest common text
set completeopt+=preview
autocmd CompleteDone * if !pumvisible() | pclose | endif
" }}}

" Lightline Setup {{{
" let g:lightline = {
" \   'colorscheme': 'gruvbox'
" \}
" }}}

" Airline Setup {{{
let g:airline_extensions = ["branch", "fugitiveline", "hunks", "languageclient", "obsession", "tabline", "tagbar", "vimcmake", "vimtex", "whitespace", "wordcount"]
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#vimtex#wordcount = 1
" }}}

" Tmuxline Setup {{{
" let g:tmuxline_preset = 'full'
" let g:tmuxline_preset = 'powerline'
" }}}

" LanguageClient Setup {{{
let g:LanguageClient_serverCommands = {
\   'c': ['clangd', '-header-insertion=iwyu', '-header-insertion-decorators', '-query-driver=/usr/**/arm-none-eabi*', '--completion-style=detailed', '--malloc-trim', '--enable-config', '--use-dirty-headers'],
\   'cpp': ['clangd', '-header-insertion=iwyu', '-header-insertion-decorators', '-query-driver=/usr/**/arm-none-eabi*', '--completion-style=detailed', '--malloc-trim', '--enable-config', '--use-dirty-headers'],
\   'rust': ['rls'],
\   'go': ['gopls'],
\   'java': ['jdtls.sh'],
\   'python': ['pylsp'],
\   'javascript': ['typescript-language-server', '--stdio'],
\   'javascriptreact': ['typescript-language-server', '--stdio'],
\   'typescript': ['typescript-language-server', '--stdio'],
\   'typescriptreact': ['typescript-language-server', '--stdio'],
\   'css': ['css-languageserver', '--stdio'],
\   'sass': ['css-languageserver', '--stdio'],
\   'scss': ['css-languageserver', '--stdio'],
\   'tex': ['texlab'],
\   'sh': ['bash-language-server', 'start'],
\   'cmake': ['cmake-language-server']
\ }

nmap <F5> <Plug>(lcn-menu)
nmap <silent>KK <Plug>(lcn-hover)
nmap <silent> Kk <Plug>(lcn-code-action)
 " Use direct call for now as it is the only possibility to give split argument
nnoremap <silent> gd :call LanguageClient#textDocument_definition({'gotoCmd': 'tabnew'})<CR>
" nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> <F2> <Plug>(lcn-rename)
nmap <silent> <A-S-f> <Plug>(lcn-format)
nnoremap <silent> <F12> :call LanguageClient#textDocument_switchSourceHeader()<CR>

" nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
" nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
" nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
" nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
" nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
" nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
" nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
" nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
" nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
" nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
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
    disable = { "cmake", "vim" },

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

" Echodoc Setup {{{
let g:echodoc#enable_at_startup = 1
" let g:echodoc#type = 'signature'
let g:echodoc#type = 'floating'
" }}}

" Neosnippets Setup {{{
let g:neosnippet#enable_complete_done = 1
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.config/nvim/plugged/vim-snippets/snippets'
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
let g:vimtex_view_automatic_xwin = 0
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
" let g:EditorConfig_exclude_patterns = ['fugitive://.\*']
" }}}

" Startify Setup {{{
" let g:startify_files_number = 5

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
  if !isdirectory(expand('~').'/.local/share/nvim/undo')
    silent !mkdir -p ~/.local/share/nvim/undo > /dev/null 2>&1
  endif
  set undodir=~/.local/share/nvim/undo
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

" enforce dark color scheme
" set background=light

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
if $COLORTERM == "truecolor"
    set termguicolors
endif

" How fast some features update (some airline plugins, tagbar, ...)
set updatetime=300

" Colorscheme
colorscheme gruvbox
" Transparent background
" autocmd BufEnter * :highlight Normal ctermbg=None

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

"" autoxrdb
" autocmd BufWritePost *.Xresources,*.Xdefaults :silent !xrdb -merge %

" format JSON using jq
autocmd FileType json map <silent> <A-S-f> :silent %!jq .<CR>
" }}}
