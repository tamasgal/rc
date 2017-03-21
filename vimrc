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

" Git
let g:snips_author='Tamas Gal'
let g:snips_email='himself@tamasgal.com'
let g:snips_github='https://github.com/tamasgal'
let g:snips_email_km3net='tgal@km3net.de'
let g:snips_git_km3net='https://git.km3net.de/tgal'

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
"highlight OverLength ctermbg=blue ctermfg=white guibg=red
" match OverLength /\%81v.\+/
highlight ColorColumn ctermbg=blue
set colorcolumn=80

" Frequently used stuff
nnoremap <Leader>w :wq!<CR>
nnoremap <Leader>q :q!<CR>
nnoremap ; :

" vimrc
:nnoremap <leader>ev :split $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>


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
Plugin 'tpope/vim-vinegar'
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
"Plugin 'scrooloose/nerdtree'
"Plugin 'scrooloose/nerdcommenter'
"Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tomtom/tcomment_vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'Chiel92/vim-autoformat'
Plugin 'junegunn/vim-easy-align'
Plugin 'junegunn/limelight.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'mileszs/ack.vim'
Plugin 'nixon/vim-vmath'
Plugin 'airblade/vim-gitgutter'
Plugin 'easymotion/vim-easymotion'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'Valloric/YouCompleteMe'

" Snippets and deps
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'tamasgal/vim-snippets'

call vundle#end()

filetype plugin indent on


let g:rainbow_active = 1
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

" Move lines with _ and -
" nnoremap - ddkP
" nnoremap _ ddp

" Easy Paste
:nnoremap <leader>p :setlocal paste!<cr>

" AutoFormat
noremap <F3> :Autoformat<CR>

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
"let g:netrw_altv = 1
let g:netrw_winsize = 25
nnoremap <space> :Lexplore<CR>

" ag / ack
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack
nmap <leader>a :tab split<CR>:Ack ""<Left>
nmap <leader>A :tab split<CR>:Ack <C-r><C-w><Left>

" vmath
vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++

" Limelight
nmap <Leader>l :Limelight!!<CR>
xmap <Leader>l :Limelight!!<CR>

" Goyo
nmap <Leader>g :Goyo<CR>
xmap <Leader>g :Goyo<CR>

function! s:goyo_enter()
    colorscheme pencil
endfunction

function! s:goyo_leave()
    colorscheme hemisu
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" CtrlP
set wildignore+=*.a,*.o,*.so
set wildignore+=*.bmp,*.gif,*.ico,*.pdf,*.jpg,*.png,*.h5
set wildignore+=*.DS_Store
set wildignore+=*.swp,*~

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

" YouCompleteMe
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_path_to_python_interpreter = '/Users/tamasgal/.pyenv/shims/python'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0
let g:ycm_collect_identifiers_from_tag_files = 1
set completeopt=longest,menu

" Snipmate
imap <C-J> <esc>a<Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Line movement
nnoremap H 0
nnoremap L $

" Quick escape
:inoremap jk <esc>
":inoremap <esc> <nop>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

map <silent> <Leader>e :Errors<CR>
map <Leader>s :SyntasticToggleMode<CR>

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open = 1
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

" Colours
nnoremap <Leader>m :call ShutterToggle()<CR>
let g:shutter_is_open=1

function! ShutterToggle()
    if g:shutter_is_open
        :call ActivateDarkTheme()
        let g:shutter_is_open=0
    else
        :call ActivateLightTheme()
        let g:shutter_is_open=1
    endif
endfunction

function! ActivateDarkTheme()
    let g:airline_theme="zenburn"
    colo sierra
    hi CursorLine cterm=NONE ctermbg=238
    hi CursorColumn cterm=NONE ctermbg=238
    hi ColorColumn ctermbg=237
endfunction

function! ActivateLightTheme()
    let g:airline_theme="papercolor"
    colo hemisu
    hi CursorLine cterm=NONE ctermbg=255
    let &colorcolumn=join(range(81,999),",")
    hi CursorColumn cterm=NONE ctermbg=255
    hi ColorColumn ctermbg=255
    " hi Normal guibg=#32322f ctermbg=255
    hi NonText guibg=#32322f ctermbg=255
    " hi ColorColumn guibg=#000000 ctermbg=231
    " let &colorcolumn=join(range(1,80),",")
endfunction

:call ActivateLightTheme()

" Airline
set laststatus=2
let g:airline_powerline_fonts = 1

set guifont=Source\ Code\ Pro\ for\ Powerline:h12

" Notes
:let g:notes_directories = ['~/Documents/Notes']

" Highlights
set cursorcolumn
set cursorline

