call plug#begin('~/.config/nvim/plugged')
Plug 'benekastah/neomake'

Plug 'tpope/vim-fugitive'

Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'tamasgal/vim-snippets'

Plug 'luochen1990/rainbow'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'easymotion/vim-easymotion'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" Syntax and Semantics
syntax on
let mapleader = ","

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

" DeoPlete
let g:deoplete#enable_at_startup = 1

let g:pymode_lint=0 " using neomake for linting
let g:pymode_rope=0 " using deoplete for auto-completion
let g:pymode_python='python3'

" Neomake (linting)
" enable Neomake on open and write but not on exit
autocmd! BufWritePost,BufReadPost * Neomake

" python linting
autocmd! BufWritePost,BufEnter * Neomake
autocmd! QuitPre * let g:neomake_verbose = 0

highlight NeoMakeErrorSign ctermfg=196
highlight NeoMakeError ctermfg=196
highlight NeoMakeWarningSign ctermfg=226
highlight NeoMakeWarning ctermfg=226
let g:neomake_warning_sign={'text': '•', 'texthl': 'NeomakeWarningSign'}

" python linting
function SetWarningType(entry)
    let a:entry.type = 'W'
endfunction

let g:neomake_tex_enabled_makers = []
let g:neomake_python_enabled_makers = ['pycodestyle', 'pyflakes']
let g:neomake_python_pycodestyle_maker = {
    \ 'args': ['--max-line-length=90', '--ignore=E741' ],
    \ 'postprocess': function('SetWarningType')
    \ }

let g:neomake_cpp_gcc_maker = {
    \ 'args': [ '--std=c++14', '-fsyntax-only', '-Wall', '-Wextra', '-pedantic']
    \ }


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

" Supertab
let g:SuperTabDefaultCompletionType = '<C-n>'

" jk
:inoremap jk <esc>
map <Leader>L <Plug>(easymotion-bd-jk)

" CtrlP
set wildignore+=*.a,*.o,*.so
set wildignore+=*.bmp,*.gif,*.ico,*.pdf,*.jpg,*.png,*.h5
set wildignore+=*.DS_Store
set wildignore+=*.swp,*~

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" Snipmate
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"

" Git
let g:snips_author='Tamas Gal'
let g:snips_email='himself@tamasgal.com'
let g:snips_github='https://github.com/tamasgal'
let g:snips_email_km3net='tgal@km3net.de'
let g:snips_git_km3net='https://git.km3net.de/tgal'

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1



set t_Co=256
let base16colorspace=256
colorscheme base16-default-dark

" Highlights
set cursorcolumn
set cursorline

hi Search cterm=NONE ctermfg=black ctermbg=lightblue
" hi MatchParen cterm=none ctermfg=black ctermbg=lightgreen
hi MatchParen cterm=bold ctermfg=none ctermbg=none
