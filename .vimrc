set nocompatible
"This line is required for Vim < 7.4
"filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

"let Vundle manage Vundle
"required! git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"The others will install automatically with :BundleInstall
Bundle 'gmarik/vundle'

"The bundles you install will be listed here
if has("gui_running")
    Bundle 'Lokaltog/powerline', {'rtp':'powerline/bindings/vim/'}
    "required font here:https://github.com/Lokaltog/powerline-fonts
    "I'm using Inconsolata for Powerline
endif

Bundle "klen/python-mode"
Bundle "davidhalter/jedi-vim"

"Setup PowerLine
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9

filetype plugin indent on

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

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

let mapleader=","

"Map ; to :
nnoremap ; :

"Save file on losing focus
au FocusLost * :wa

"Save and restore fold state
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview

"Python stuff
"Set up :make
autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

"Python-mode
"Activate rope
"Keys:
"K             Show python docs
"<Ctrl-Space>  Rope autocomplete
"<Ctrl-c>g     Rope goto definition
"<Ctrl-c>d     Rope show documentation
"<Ctrl-c>f     Rope find occurrences
"<Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
"[[            Jump on previous class or function (normal, visual, operator modes)
"]]            Jump on next class or function (normal, visual, operator modes)
"[M            Jump on previous class or method (normal, visual, operator modes)
"]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0

"Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
"Auto check on save
let g:pymode_lint_write = 1

"Support virtualenv
let g:pymode_virtualenv = 1

"Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

"syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

"Don't autofold code
let g:pymode_folding = 0

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

