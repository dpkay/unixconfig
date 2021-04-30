" dpk@pixar.com

" various
set nocompatible
set autoindent
" set smartindent " breaks python comments
set expandtab
set tabstop=2
set shiftwidth=2
set smarttab
set softtabstop=2
set showmatch
set ruler
set incsearch
set nu
set linebreak
set nojoinspaces
set ignorecase
set smartcase
set autoread
set hlsearch
set hidden
set history=100
syntax enable
set wildignore=*.obj,*.o,*.png,*copy/*,*/build/*,*Frameworks*
filetype off

"set rtp+=$UNIXCONFIG/vimfiles/bundle/vundle/
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'gmarik/vundle'
Plugin 'SirVer/ultisnips'
"Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-abolish'

filetype on
filetype plugin on

" disable all gui stuff
set guioptions-=m
set guioptions-=T
set guioptions-=r

" color scheme and fonts
set t_Co=256
set term=screen-256color
colorscheme mustang
if has("gui_macvim")
    set guifont=Menlo:h14
    colorscheme mustang
    set transparency=4
    set background=dark
    set linespace=2
"    set lines=42
"   set columns=120
elseif has("gui_win32")
    "set term=xterm
    set guifont=Consolas:h13:cANSI
    colorscheme mustang
    cabbr Fbig set guifont=Consolas:h13:cANSI
    cabbr Fsmall set guifont=Consolas:h11:cANSI
    "set guifont=Source\ Code\ Pro\ Semibold:h12:cANSI,Consolas:h13:cANSI
    cd $HOME
    set lines=41
    set columns=120
elseif has("gui_running")
    set guifont=Monospace\ 11
    colorscheme mustang
    set lines=41
    set columns=120
else
    "probably from linux terminal
    colorscheme mustang
endif

" statusline layout
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding},                " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=0x%-8B\                      " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" plugin config: a.vim
let g:alternateExtensions_h = "c,cpp,cxx,cc,CC,m,mm"
let g:alternateExtensions_cpp = "h,hpp"
let g:alternateExtensions_m = "h"
let g:alternateExtensions_mm = "h,hpp"

" plugin config: omnicomplete
set ofu=syntaxcomplete#Complete

" autoformat
set formatprg=par

" keymaps
let mapleader = "\\"
nmap <right> <nop>
nmap <left> <nop>
nmap <up> <nop>
nmap <down> <nop>
nmap <C-p> :cp<CR>
nmap <C-n> :cn<CR>
nmap <C-l> :TlistOpen<CR>zz
nmap <C-k> :TlistShowPrototype<CR>

" aliases
cabbr B call QNameBufInit(0, 0, 0, 0)<CR>:~
cabbr Ch cd %:h
command! -nargs=+ Ps !perl -pe <args>
cabbr Sv sp $UNIXCONFIG/vimfiles/vimrc.vim
cabbr Uc Ex $UNIXCONFIG
cabbr Sz sp ~/.zshrc
cabbr Sc sp ~/.cshrc
cabbr Sne Ex ~/box/notes
cabbr C1 cd $C1_DIR
cabbr C2 cd $C2_DIR
cabbr C3 cd $C3_DIR
cabbr C4 cd $C4_DIR
cabbr C5 cd $C5_DIR
:command! -nargs=+ EE :silent!:execute ':w | :execute ":! <args> >& /tmp/vim_err" | :cope 10 | :cf /tmp/vim_err'
:command! -nargs=* Sn e ~/Dropbox/notes/<args>.txt
:command! Hlo :silent!:execute ':highlight OverLength ctermbg=red ctermfg=white guibg=#592929 | :match OverLength /\%81v.\+/'

" xml
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" win/unix compatibility
set fileformat=unix
set fileformats=unix,dos

" goog
if has("gui_win32")
  cabbr Ce cd c:\g4root\earth\googleclient\earth\client
endif

function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction

autocmd BufWritePre     * :call TrimWhiteSpace()
"autocmd FileType c,cpp,cc,h,py,gyp,gypi,scons autocmd BufWritePre  * :call TrimWhiteSpace()

" git grep
func GitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep'
  for i in a:000
    let s = s . ' ' . i
  endfor
  exe s
  let &grepprg = save
endfun
command -nargs=? G call GitGrep(<f-args>)

let g:EasyMotion_leader_key='<Space>'

" par
set fp=par\ -w80

noremap <C-B> :py3file /usr/lib/clang-format/clang-format.py<CR>
inoremap <C-B> <C-O>:py3file /usr/lib/clang-format/clang-format.py<CR>
