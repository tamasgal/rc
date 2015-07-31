" File: .vimrc
" Version: 1
" Author: Tamas Gal
" Created: 21 Jan 2003 9:40:01
"
" Last-modified: 24 June 2015 22:24:23

set nocompatible              " be iMproved, required
filetype off                  " required
syntax on
let mapleader = ","

set encoding=utf8
set term=xterm-256color

set shiftwidth=4 softtabstop=4
set expandtab
set number
set relativenumber
set showmatch
set smartcase
set scrolloff=2

set ruler
set cursorcolumn

" Search options
set ignorecase
set smartcase
set hlsearch

" Highlight lines with more than 80columns
" highlight OverLength ctermbg=red ctermfg=white guibg=red
" match OverLength /\%81v.\+/
set colorcolumn=80

" Trailing whitespace
match ErrorMsg '\s\+$'
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'flazz/vim-colorschemes.git'
Plugin 'bling/vim-airline'
Plugin 'Shougo/vimproc'
Plugin 'eagletmt/ghcmod-vim'
"Plugin 'altercation/vim-colors-solarized'

call vundle#end()            " required
filetype plugin indent on    " required


" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

map <silent> <Leader>e :Errors<CR>
map <Leader>s :SyntasticToggleMode<CR>

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_html_tidy_ignore_errors=["<ion-", "discarding unexpected </ion-", " proprietary attribute \"ng-"]

" GHC-mod
map <Leader>t :GhcModType<CR>
map <Leader>c :GhcModCheck<CR>

" Solarized
"set background=light
"colorscheme solarized
"let g:solarized_termcolors=   256
"let g:solarized_termtrans =   0
"let g:solarized_degrade   =   0
"let g:solarized_bold      =   1
"let g:solarized_underline =   1
"let g:solarized_italic    =   1
"let g:solarized_contrast  =   "high"
"let g:solarized_visibility=   "normal"
"if !has('gui_running')
"    " Compatibility for Terminal
"    let g:solarized_termtrans=1
"
"    if (&t_Co >= 256 || $TERM == 'xterm-256color')
"        " Do nothing, it handles itself.
"    else
"        " Make Solarized use 16 colors for Terminal support
"        let g:solarized_termcolors=16
"    endif
"endif

" Color schemt
colo hemisu

" Airline
set laststatus=2
let g:airline_theme="powerlineish"
let g:airline_powerline_fonts = 1

set guifont=Source\ Code\ Pro\ for\ Powerline:h12
