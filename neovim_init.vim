call plug#begin('~/.config/nvim/plugged')
Plug 'benekastah/neomake'
Plug 'w0rp/ale'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'

Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'tamasgal/vim-snippets'


Plug 'lervag/vimtex'
Plug 'rhysd/vim-grammarous'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax' 
Plug 'tomtom/tcomment_vim'

Plug 'luochen1990/rainbow'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'sbdchd/neoformat'
Plug 'JuliaEditorSupport/julia-vim'
" Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'
Plug 'manabuishii/vim-cwl'
Plug 'diego-treitos/MuttAliasesAutoCompletion'

Plug 'dhruvasagar/vim-table-mode'

Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

let uname = substitute(system('uname'), '\n', '', '')
" Example values: Linux, Darwin, MINGW64_NT-10.0, MINGW32_NT-6.1

" Syntax and Semantics
syntax on
let mapleader = ","
let maplocalleader = "\\"

set shiftwidth=4 softtabstop=4
set expandtab
set number
set relativenumber
set nofoldenable
set showmatch
set showcmd
set smartcase
set scrolloff=2
set ruler
set backspace=indent,eol,start
set colorcolumn=80
au BufRead /tmp/mutt-* set tw=72
augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile *mutt-*              setfiletype mail
augroup END

set formatprg=par\ -w79

" Remember cursor position between vim sessions
autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif

" Mutt aliases
let g:mutt_aliases_path = "~/.mutt/aliases"

" DeoPlete
let g:deoplete#enable_at_startup = 1

let g:pymode_lint=0 " using neomake or ale for linting
let g:pymode_rope=0 " using deoplete for auto-completion
let g:pymode_python='python'

" completion
" enable ncm2 for all buffers
" autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANT: :help Ncm2PopupOpen for more information
" set completeopt=noinsert,menuone,noselect


" ale
let g:ale_lint_on_enter = 1
" let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_linters = {
  \ 'python': ['flake8', 'mypy', 'pylint'] ,
  \ }
let g:ale_fixers = {
  \ 'python': ['autopep8', 'yapf'] ,
  \ }
let g:ale_python_mypy_options = '--ignore-missing-imports'
" let g:ale_sign_error = '⊛⊛⨀⨂●⦿'
let g:ale_sign_error = '●'
let g:ale_sign_warning = '•'
let g:ale_set_highlights = 0
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign
" highlight ALEWarningSign ctermfg=11 ctermbg=15 guifg=#ED6237 guibg=#F5F5F5


" neoformat
let g:tex_flavor = "latex"
let g:neoformat_tex_latexindent = {
  \ 'exe': 'latexindent',
  \ 'args': ['-l'],
  \ 'stdin': 1
  \ }

" tables
" markdown style
let g:table_mode_corner='|'
" ReST style
" let g:table_mode_corner_corner='+'
" let g:table_mode_header_fillchar='='

" xclip - ClipBoard stuff
" copy to primary
:map <F7> :w !xclip<CR><CR>
:vmap <F7> "*y
:map <F8> :r!xclip -o<CR>
" copy to clipboard
" shift F7 and shift F8
:map <F19> :w !xclip -selection clipboard<CR><CR>
:vmap <F19> "+y
:map <F20> :r!xclip -selection clipboard -o<CR>

" kill arrow keys, die!!!
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Dealing with buffers
nnoremap <leader>bb :buffers<cr>:b<space> 
nnoremap <leader>bd :bd<cr> 
" switches to the most recent buffer
nnoremap <leader><tab> :b#<cr>

" Navigating tabs
nnoremap H gT
nnoremap L gt

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

" remove trailing whitespace
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" quick formatting of paragraph
nnoremap <Leader>p mPgqip`P

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

nnoremap <leader>g :Gwrite<bar>Gcommit<cr>

" vimtex
if uname == 'Linux'
    let g:vimtex_view_method = 'zathura'
elseif uname == 'Darwin'
    let g:vimtex_view_method = 'skim'
endif
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-lualatex',
    \   '-shell-escape',
    \   '-verbose',
    \   '-bibtex',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

" Bibtex
" autocmd FileType bib nmap <leader>b "zyy:!zathura <C-r>=substitute(substitute(@z,'.*pdf[^{]*{\([^}]*\)}.*','\1',''),'\s','\\ ','g')<CR> &<CR><CR>

" vim-pandoc
let g:pandoc#modules#disabled = ["folding"]

" julia
let g:default_julia_version = '1.0'

" language server
" let g:LanguageClient_autoStart = 1
" let g:LanguageClient_serverCommands = {
" \   'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
" \       using LanguageServer;
" \       using Pkg;
" \       import StaticLint;
" \       import SymbolServer;
" \       env_path = dirname(Pkg.Types.Context().env.project_file);
" \       debug = false; 
" \       
" \       server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "", Dict());
" \       server.runlinter = true;
" \       run(server);
" \   ']
" \ }
"
" nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Toggle spellchecking
function! ToggleSpellCheck()
  set spell!
  if &spell
    echo "Spellcheck ON"
  else
    echo "Spellcheck OFF"
  endif
endfunction

nnoremap <silent> <Leader>s :call ToggleSpellCheck()<CR>

nnoremap <silent> <Leader>sd :set spell spelllang=de_de<CR>
nnoremap <silent> <Leader>se :set spell spelllang=en_us<CR>


set t_Co=256
let base16colorspace=256
colorscheme base16-default-dark

" Highlights
" set cursorcolumn
" set cursorline
" highlight CursorColumn ctermbg=234 ctermfg=none
" highlight CursorLine ctermbg=237 ctermfg=none
highlight clear SignColumn

hi Search cterm=NONE ctermfg=black ctermbg=lightblue
" hi MatchParen cterm=none ctermfg=black ctermbg=lightgreen
hi MatchParen cterm=bold ctermfg=none ctermbg=none

highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
