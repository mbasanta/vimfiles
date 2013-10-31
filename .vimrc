set nocompatible

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

"Map ; to :
nnoremap ; :

"Supposed to save file on losing focus, I don't think it works
au FocusLost * :wa

"Save and restore fold state
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview

"Python stuff
"Set up :make
autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

"Set up the GUI
colorscheme molokai
if has('gui_running')
    set lines=40 columns=100
    set guifont=Consolas:h10:cANSI
else
    if exists('+lines')
        set lines=40
    endif
    if exists('+columns')
        set columns=100
    endif
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
