set nocompatible

"Setup Vundle
filetype off

set runtimepath+=~/vim/bundle/Vundle.vim
call vundle#rc()
Bundle 'gmarik/Vundle.vim'

Bundle 'davidhalter/jedi-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/powerline'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-commentary'
Bundle 'peterhoeg/vim-qml'
Bundle 'sukima/xmledit'

filetype plugin indent on

"Setup pwerline
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim/

"Setup NERDTree
map <F2> :NERDTreeToggle<CR>

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" Switch quickly between indentations
nnoremap 2sp :set sw=2 sts=2 ts=2<CR>
nnoremap 4sp :set sw=4 sts=4 ts=4<CR>
" Set tabs on document specific scale
autocmd FileType html :setlocal sw=2 sts=2 ts=2

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set undofile
set autochdir

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

"Turn off the toolbar by default
set guioptions-=T

"Show some hidden characters
set list
set listchars=tab:▸\ ,eol:¬

syntax on

let mapleader=","

"Code competion with ctrl-space
"inoremap <C-Space> <C-x><C-o>
"inoremap <C-@> <C-Space>

"Save file on losing focus
au FocusLost * :wa

"Save and restore fold state
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview

"Python stuff
"Set up :make
autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

"Show .md with markdown syntax
au BufRead,BufNewFile *.md set filetype=markdown

"Set up the GUI
colorscheme molokai
if has('gui_running')
    set lines=40 columns=120
    set guifont=Inconsolata\ for\ Powerline:h12
endif

"Some custom functions for tabs
"Set tabstop, softtabs and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
    let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
    if l:tabstop > 0
        let &l:sts = l:tabstop
        let &l:ts = l:tabstop
        let &l:sw = l:tabstop
    endif
    call SummarizeTabs()
endfunction

function! SummarizeTabs()
    try
        echohl ModeMsg
        echon 'tabstop='.&l:ts
        echon 'shiftwidth='.&l:sw
        echon 'softtabstop='.&l:sts
        if &l:et
            echon ' expandtab'
        else
            echon ' noexpandtab'
        endif
    finally
        echohl None
    endtry
endfunction

" Function to activate a virtualenv in the embedded interpreter for
" omnicomplete and other things like that.
function! LoadVirtualEnv(path)
    let full_path =  '/users/matthewbasanta/virtualenvs/' . a:path
    let activate_this = full_path . '/bin/activate_this.py'
    if getftype(full_path) == "dir" && filereadable(activate_this)
        python << EOF
import vim
activate_this = vim.eval('l:activate_this')
execfile(activate_this, dict(__file__=activate_this))
EOF
    endif
endfunction

" Load up a 'stable' virtualenv if one exists in ~/.virtualenv
let defaultvirtualenv = $HOME . "/virtualenvs/stable"

" Only attempt to load this virtualenv if the defaultvirtualenv
" actually exists, and we aren't running with a virtualenv active.
if has("python")
    if empty($VIRTUAL_ENV) && getftype(defaultvirtualenv) == "dir"
        call LoadVirtualEnv(defaultvirtualenv)
    endif
endif
