" File: .vimrc             
" Version: 1
" Author: Tamas Gal
" Created: 21 Jan 2003 9:40:01

" Last-modified: 15 July 2013 08:24:23

let $VIMROOT = expand("$HOME") . "/sandbox/rc/vim"

set shiftwidth=4 softtabstop=4
"set number
set relativenumber
set showmatch
set smartcase
set scrolloff=2

" show the cursor position all the time
set ruler

" Indented fold
set foldmethod=indent

" Cursor highlight
set cursorcolumn

" Always display the status line, even if only one window is displayed
set laststatus=2
set statusline=%F%m%r%h%w\ [\%03.3b/\%02.2B]\ [%04l,%03v][%02p%%,%L] 

" Color scheme
"syntax enable
"set background=dark
"colorscheme solarized
"------------------------------------------------------------------
" Solarized Colorscheme Config
" ------------------------------------------------------------------
if has ('gui_running')
    syntax enable
    set background=light
    colorscheme solarized
endif
" ------------------------------------------------------------------
"
"  " The following items are available options, but do not need to be
"  " included in your .vimrc as they are currently set to their defaults.
"
" let g:solarized_termtrans=0
" let g:solarized_degrade=0
" let g:solarized_bold=1
" let g:solarized_underline=1
" let g:solarized_italic=1
" let g:solarized_termcolors=16
" let g:solarized_contrast="high"
" let g:solarized_visibility="normal"
" let g:solarized_diffmode="normal"
" let g:solarized_hitrail=0
" let g:solarized_menu=1
"

" Highlight lines with more than 80columns
highlight OverLength ctermbg=red ctermfg=white guibg=red
match OverLength /\%81v.\+/

set colorcolumn=80
" easier formatting of paragraphs (wrapping)
vmap Q gq
nmap Q gqap

" cdunklau's color margin!
"execute "set colorcolumn=" . join(range(80, 200), ',')
"highlight ColorColumn ctermbg=7
set tabstop=8
set shiftwidth=4
set expandtab
set softtabstop=4 " Backspace goes back 4 spaces
set backspace=indent,eol,start
autocmd FileType make setlocal noexpandtab " no fake tabs in makefiles

set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace

filetype plugin on
"filetype indent on

set omnifunc=syntaxcomplete#Complete

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Height of the command bar
set cmdheight=2

" Search options
set ignorecase
set smartcase
set hlsearch

" Form feed page break marker!
"function! FoldPageFeed()
"    setl foldmethod=expr
"    setl foldexpr=getline(v:lnum)[0]==\"\\<c-l>\"
"    setl foldminlines=0
"    setl foldtext='---\ new\ page\ '
"    setl foldlevel=0
"    set foldclose=all
"endfunction
"autocmd FileType py exe FoldPageFeed()


" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
"
" " Use Unix as the standard file type
" set ffs=unix,dos,mac


" TaskList open
map T :TaskList<CR>

" Taglist toggle
nnoremap <silent> <F8> :TlistToggle<CR>

" Mini Buffer Explorer
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1 
nnoremap <silent> <F9> :TMiniBufExplorer<CR>

nnoremap <F10> :call HexMe()<CR>

let $in_hex=0
function HexMe()
    set binary
    set noeol
    if $in_hex>0
        :%!xxd -r
        let $in_hex=0
    else
        :%!xxd
        let $in_hex=1
    endif
endfunction

" Binary editing
augroup Binary
    au!
    au BufReadPre *.bin let &bin=1
    au BufReadPost *.bin if &bin | %!xxd
    au BufReadPost *.bin set ft=xxd | endif
    au BufWritePre *.bin if &bin | %!xxd -r
    au BufWritePre *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 100 previously edited files
"  "100 :  will save up to 150 lines for each register
"  :20  :  up to 23 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo


au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


" =========================
" Bundle settings
set nocompatible            " be iMproved
filetype off                " required for vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Bundle 'gmarik/Vundle.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'tpope/vim-surround'
Bundle 'chrisbra/Replay'
Bundle "myusuf3/numbers.vim"
Bundle "scrooloose/nerdtree"

" My Bundles (original repos on github)

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused
" bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..


function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

:let mapleader = ","

" Close buffer without closing the window
nnoremap <C-c> :bp\|bd #<CR>

" ,ack to search the word under the cursor
silent noremap <Leader>ack :exec 'Ack '.expand("<cword>")<CR>

" Shift+Tab to show the list of jumps in the tag stack
nmap  <C-Tab>  :tags<CR>

" Ctrl+p to write and run current file via pyton
map <C-p>   :w<CR>:!python %<CR>
imap <C-p>   <Esc>:w<CR>:!python %<CR>

" Toggle NERDTree with F3
nmap <silent> <F3> :NERDTreeToggle<CR>

syntax on


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

