" File: .vimrc
" Version: 1
" Author: Tamas Gal
" Created: 21 Jan 2003 9:40:01
"
" Last-modified: 24 June 2015 22:24:23

" Syntax and Semantics
set nocompatible              " be iMproved, required
filetype off
syntax on
let mapleader = ","

set encoding=utf8
set term=xterm-256color
if exists('$TMUX')
  set term=screen-256color
endif

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

set shiftwidth=4 softtabstop=4
set expandtab
set number
set relativenumber
set showmatch
set showcmd
set smartcase
set scrolloff=2
set ruler
set backspace=indent,eol,start

"set cpoptions+=$            " dollar sign while changing
set pumheight=7            " limit popup menu height
set t_ut=                   " fix 256 colors in tmux http://sunaku.github.io/vim-256color-bce.html

" for html/rb files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab

" TypeScript
autocmd BufNewFile,BufRead *.ts setfiletype typescript syntax=typescript
autocmd BufNewFile,BufRead *.tsx setfiletype typescript syntax=typescript
autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
autocmd BufNewFile,BufRead *.es6 setfiletype javascript syntax=javascript
autocmd BufNewFile,BufRead *.es7 setfiletype javascript syntax=javascript


" Search options
set ignorecase
set smartcase
set hlsearch

" Highlight lines with more than 80columns
" highlight OverLength ctermbg=red ctermfg=white guibg=red
" match OverLength /\%81v.\+/
set colorcolumn=80

" Frequently used stuff
nnoremap <Leader>w :wq!<CR>
nnoremap <Leader>q :q!<CR>
" Trailing whitespace
match ErrorMsg '\s\+$'
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" Vundle and Plug-in
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
Plugin 'gmarik/Vundle.vim'
Plugin 'JuliaLang/julia-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'flazz/vim-colorschemes.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Shougo/vimproc'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'luochen1990/rainbow'
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'vimwiki/vimwiki'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'Chiel92/vim-autoformat'
Plugin 'junegunn/vim-easy-align'
Plugin 'Valloric/YouCompleteMe'
Plugin 'davidhalter/jedi-vim'
"Plugin 'marijnh/tern_for_vim'
call vundle#end()

filetype plugin indent on


let g:rainbow_active = 0
let g:rainbow_conf = {
\   'guifgs': ['lightblue', 'green', 'red', 'magenta'],
\   'ctermfgs': ['lightblue', 'green', 'red', 'magenta'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'lisp': {
\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'css': 0,
\   }
\}

" Use tab to jump between tabs
nnoremap <tab> :tabn<CR>
"vnoremap <tab> %

" Split naturally
set splitbelow
set splitright
map <Leader>- :vsp<CR>
map <Leader>_ :sp<CR>

" AutoFormat
noremap <F3> :Autoformat<CR>

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
" open with nerdtree if nothing else specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" Tern settings
let g:tern_show_argument_hints='on_hold'
let g:tern_map_keys = 1

" pymode
set nofoldenable
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

map <silent> <Leader>e :Errors<CR>
map <Leader>s :SyntasticToggleMode<CR>

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_tidy_ignore_errors=["<ion-", "discarding unexpected </ion-", " proprietary attribute \"ng-"]
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = '¬'
let g:syntastic_loc_list_height=3

" Unit test (python)
"map <Leader>r :! py.test -l %<CR>
nnoremap <Leader>u :! py.test -l<CR>

" GHC-mod
map <Leader>t :GhcModType<CR>
map <Leader>c :GhcModCheck<CR>

" Color schemt
colo hemisu
"colo sierra
"colo solarized

" Airline
set laststatus=2
"let g:airline_theme="powerlineish"
let g:airline_theme="papercolor"
"let g:airline_theme="solarized"
let g:airline_powerline_fonts = 1

set guifont=Source\ Code\ Pro\ for\ Powerline:h12

" JavaScript
let g:javascript_conceal_function   = "ƒ"
let g:javascript_conceal_null       = "ø"
let g:javascript_conceal_this       = "@"
let g:javascript_conceal_return     = "⇚"
let g:javascript_conceal_undefined  = "¿"
let g:javascript_conceal_NaN        = "ℕ"
let g:javascript_conceal_prototype  = "¶"
let g:javascript_conceal_static     = "•"
let g:javascript_conceal_super      = "Ω"

" Notes
:let g:notes_directories = ['~/Documents/Notes']

" Highlights
"hi CursorColumn cterm=NONE ctermbg=223
hi CursorLine cterm=NONE ctermbg=255
hi CursorColumn cterm=NONE ctermbg=255
set cursorcolumn
set cursorline
"hi Search cterm=NONE ctermfg=white ctermbg=darkcyan

