"
" ======================= PLUGINS =======================
"
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ~/.config/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

" Vim-Plug Setup
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

    " Statusline
    " Plug 'vim-airline/vim-airline' " Really slow (adds over 200ms startup time without extensions)
    " Plug 'vim-airline/vim-airline-themes'
    Plug 'itchyny/lightline.vim'

    " Startup Screen
    " Plug 'mhinz/vim-startify'

    " IDE?
    Plug 'editorconfig/editorconfig-vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/fzf'
    Plug 'majutsushi/tagbar'
    " Plug 'ryanoasis/vim-devicons'
    " Plug 'scrooloose/nerdtree'
    Plug 'tpope/vim-commentary'
    " Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-sleuth'
    Plug 'wsdjeg/vim-todo'
    Plug 'wsdjeg/FlyGrep.vim'
    Plug 'tpope/vim-obsession'

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
    " Plug 'lervag/vimtex'

    " Snippets
    Plug 'Shougo/neosnippet-snippets'
    Plug 'Shougo/neosnippet.vim'
    Plug 'honza/vim-snippets'

    " TMUX integration
     Plug 'tmux-plugins/vim-tmux-focus-events' " makes automatic reloading of changed files work (in tmux)
     " Plug 'edkolev/tmuxline.vim'
call plug#end()

"" Deoplete Setup
" let g:deoplete#enable_at_startup = 1 " don't start automatically (300ms)
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

"" Lightline Setup
let g:lightline = {
\   'colorscheme': 'gruvbox'
\}

"" Airline Setup
" let g:airline_extensions = ["tabline"]
" let g:airline_powerline_fonts = 1
" let g:airline_skip_empty_sections = 1

" " Tmuxline Setup
" let g:tmuxline_preset = 'full'
" let g:tmuxline_preset = 'powerline'

" LanguageClient Setup
let g:LanguageClient_hasSnippetSupport = 0
let g:LanguageClient_serverCommands = {
\   'c': ['clangd', '-header-insertion=iwyu', '-header-insertion-decorators'],
\   'cpp': ['clangd', '-header-insertion=iwyu', '-header-insertion-decorators', '-background-index', '-cross-file-rename'],
\   'java': ['jdtls.sh'],
\   'python': ['pyls'],
\   'javascript': ['typescript-language-server', '--stdio'],
\   'javascriptreact': ['typescript-language-server', '--stdio'],
\   'typescript': ['typescript-language-server', '--stdio'],
\   'typescriptreact': ['typescript-language-server', '--stdio'],
\   'css': ['css-languageserver', '--stdio'],
\   'sass': ['css-languageserver', '--stdio'],
\   'scss': ['css-languageserver', '--stdio'],
\   'tex': ['texlab'],
\   'sh': ['bash-language-server', 'start'],
\ }
nmap <F5> <Plug>(lcn-menu)
nmap <silent>KK <Plug>(lcn-hover)
nmap <silent> Kk <Plug>(lcn-code-action)
 " Use direct call for now as it is the only possibility to give split argument
nnoremap <silent> gd :call LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
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

" Echodoc Setup
let g:echodoc#enable_at_startup = 1
" let g:echodoc#type = 'signature'
let g:echodoc#type = 'floating'

" Neosnippets Setup
" let g:neosnippet#enable_complete_done = 1
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.config/nvim/plugged/vim-snippets/snippets'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" EditorConfig Setup
" let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

" Startify Setup
" let g:startify_files_number = 5

" let g:startify_commands = [
" \   { 'up': ['Update Plugins', ':PlugUpdate'] },
" \ ]

" let g:startify_bookmarks = [
" \   { 'c': '~/.config/nvim/init.vim' },
" \   { 'g': '~/.config/git/ignore' },
" \ ]


" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  if !isdirectory(expand('~').'/.local/share/nvim/undo')
    silent !mkdir -p ~/.local/share/nvim/undo > /dev/null 2>&1
  endif
  set undodir=~/.local/share/nvim/undo
  set undofile
endif

" ======================= VIM =======================

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

" enable 24-bit colorsupport if available
if (has("termguicolors"))
    set termguicolors
endif

" Colorscheme
colorscheme gruvbox
" Transparent background
" autocmd BufEnter * :highlight Normal ctermbg=None

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" ====================== KEYBINDINGS ======================
let mapleader = ","

" Shortcutting split navigation, saving a keypress:
map <A-h> <C-w>h
map <A-j> <C-w>j
map <A-k> <C-w>k
map <A-l> <C-w>l

" Shortcutting tab navigation
map <leader>n <ESC>:tabprevious<CR>
map <leader>m <ESC>:tabnext<CR>

nmap <silent> <F7> :NERDTreeToggle<CR>
nmap <silent> <F8> :TagbarToggle<CR>
imap <silent> <F7> <C-o><F7>
imap <silent> <F8> <C-o><F8>

nmap <silent> <C-p> :FZF<CR>

map <silent> <C-s> :Commentary<CR>
imap <C-s> <c-o><C-s>

"" Asyncronously run ~/.scripts/compiler
" map <silent> <leader>c :w<CR>:AsyncRun compiler %<CR>
" map <silent> <leader>o :silent !compiler --open "<c-r>%" & > /dev/null<CR>

"" LaTeX related stuff
" function! SyncTexForward()
" let linenumber=line(".")
" let colnumber=col(".")
" let filename=bufname("%")
" let filenamePDF=filename[:-4]."pdf"
" let execstr="silent !zathura --synctex-forward " . linenumber . ":" . colnumber . ":\"" . filename . "\" \"" . filenamePDF . "\"&>/dev/null &"
" exec execstr
" endfunction
" autocmd FileType tex map <silent> <C-b> :call SyncTexForward()<cr>

"" no plaintex
let g:tex_flavor = 'latex'

"" autoxrdb
" autocmd BufWritePost *.Xresources,*.Xdefaults :silent !xrdb -merge %

" format JSON using jq
autocmd FileType json map <silent> <A-S-f> :silent %!jq .<CR>
