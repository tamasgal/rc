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
set textwidth=80

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

" Search options
set ignorecase
set smartcase
set hlsearch

" Highlight lines with more than 80columns
"highlight OverLength ctermbg=blue ctermfg=white guibg=red
" match OverLength /\%81v.\+/
set colorcolumn=80

" Frequently used stuff
nnoremap <Leader>q :q!<CR>
nnoremap ; :

" vimrc
:nnoremap <leader>ev :split $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" Trailing whitespace
match ErrorMsg '\s\+$'
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" run make
nnoremap <Leader>m :!make<CR>

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
Plugin 'w0rp/ale'
Plugin 'flazz/vim-colorschemes.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'eagletmt/ghcmod-vim'
Plugin 'luochen1990/rainbow'
Plugin 'tomtom/tcomment_vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'junegunn/vim-easy-align'
" Plugin 'junegunn/limelight.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'mileszs/ack.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'easymotion/vim-easymotion'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'Valloric/YouCompleteMe'
Plugin 'chriskempson/base16-vim'
Plugin 'lervag/vimtex'
Plugin 'brennier/quicktex'
Plugin 'rizzatti/dash.vim'

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
nnoremap <S-tab> :tabp<CR>
"vnoremap <tab> %

" Split naturally
set splitbelow
set splitright
map <Leader>- :vsp<CR>
map <Leader>_ :sp<CR>

set diffopt+=vertical

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

" Easy Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vimtex
let g:vimtex_view_method = 'skim'

" quicktex
let g:quicktex_tex = {
    \' '   : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
    \'m'   : '\( <+++> \) <++>',
    \'prf' : "\\begin{proof}\<CR><+++>\<CR>\\end{proof}",
\}

let g:quicktex_math = {
    \' '    : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
    \'fr'   : '\mathcal{R} ',
    \'eq'   : '= ',
    \'set'  : '\{ <+++> \} <++>',
    \'frac' : '\frac{<+++>}{<++>} <++>',
    \'one'  : '1 ',
    \'st'   : ': ',
    \'in'   : '\in ',
    \'bn'   : '\mathbb{N} ',
\}

" ag / ack
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack
nmap <leader>a :tab split<CR>:Ack ""<Left>
nmap <leader>A :tab split<CR>:Ack <C-r><C-w><Left>

" Dash
:nmap <silent> <leader>h <Plug>DashSearch

" vmath
vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++

" Limelight
" nmap <Leader>l :Limelight!!<CR>
" xmap <Leader>l :Limelight!!<CR>

" Goyo
nmap <Leader>g :Goyo<CR>
xmap <Leader>g :Goyo<CR>

" CtrlP
set wildignore+=*.a,*.o,*.so
set wildignore+=*.bmp,*.gif,*.ico,*.pdf,*.jpg,*.png,*.h5
set wildignore+=*.DS_Store
set wildignore+=*.swp,*~

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" YouCompleteMe
let g:ycm_seed_identifiers_with_syntax=1
" let g:ycm_path_to_python_interpreter = '/Users/tamasgal/.pyenv/shims/python'
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

" wrapped line movement
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Quick escape
:inoremap jk <esc>
":inoremap <esc> <nop>

" ALE lint engine
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '¬'
let g:airline#extensions#ale#enabled = 1

" Unit test (python)
"map <Leader>r :! py.test -l %<CR>
nnoremap <Leader>u :! py.test -l<CR>

" GHC-mod
map <Leader>t :GhcModType<CR>
map <Leader>c :GhcModCheck<CR>

" CTAGS
command! MakeTags !/usr/local/bin/ctags -R .


" EasyMotion
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char} to move to {char}
nmap s <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
" nmap s <Plug>(easymotion-overwin-f2)
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" Search
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" Airline
set laststatus=2
let g:airline_powerline_fonts = 1

set guifont=Source\ Code\ Pro\ for\ Powerline:h12

" Notes
:let g:notes_directories = ['~/Documents/Notes']


" Colours
let base16colorspace=256 " Access colors present in 256 colorspace
set t_Co=256 " 256 color mode
set term=screen-256color
if exists('$TMUX')
  set term=screen-256color
endif
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
" Default color scheme
set background=dark
colorscheme base16-ocean

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Highlights
set cursorcolumn
set cursorline

hi Search cterm=NONE ctermfg=black ctermbg=lightblue
" hi MatchParen cterm=none ctermfg=black ctermbg=lightgreen
hi MatchParen cterm=bold ctermfg=none ctermbg=none
