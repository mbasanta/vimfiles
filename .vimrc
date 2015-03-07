" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:
"
"   This is the personal .vimrc file of Matthew Basanta. This is heavily
"   copied from Steve Francia's spf13 Vim. For more information see
"   http://github.com/spf13/spf13-vim
"
"   Copyright 2015 Matthew Basanta
"
"   Licensed under the Apache License, Version 2.0 (the "License");
"   you may not use this file except in compliance with the License.
"   You may obtain a copy of the License at
"
"       http://www.apache.org/licenses/LICENSE-2.0
"
"   Unless required by applicable law or agreed to in writing, software
"   distributed under the License is distributed on an "AS IS" BASIS,
"   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
"   See the License for the specific language governing permissions and
"   limitations under the License.
" }

" Environment {

    " Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win16') || has('win32') || has('win64'))
        endfunction
    " }

    " Basics {
        set nocompatible        " Must be first line
        filetype off            "This line is required for Vim < 7.4
        if !WINDOWS()
            set shell=/bin/sh
        endif

        " Always switch to the current file directory
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if WINDOWS()
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

" }

" Vundle Setup {

    set runtimepath+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Bundle 'gmarik/Vundle.vim'

    Bundle 'scrooloose/nerdtree'
    Bundle 'bling/vim-airline'
    Bundle 'peterhoeg/vim-qml'
    Bundle 'sukima/xmledit'

    " General Programming {
        Bundle 'scrooloose/syntastic'
        Bundle 'tpope/vim-fugitive'
        Bundle 'tpope/vim-commentary'
    " }

    " Snippets & Autocomplete {
        Bundle 'Valloric/YouCompleteMe'
    " }

    " Python {
        " Bundle 'davidhalter/jedi-vim'
    " }

    " Javascript {
        Bundle 'pangloss/vim-javascript'
    " }

    call vundle#end()

" }

" General {

    set background=dark         " Assume a dark background
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8
    set encoding=utf-8
    set termencoding=utf-8

    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore            " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set hidden
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator

    au FocusLost * :wa                  " Save file on losing focus

    "Code competion with ctrl-space
    inoremap <C-Space> <C-x><C-o>
    inoremap <C-@> <C-Space>

    " Setting up the directories {
    set backup                  " Backups are nice ...
    if has('persistent_undo')
        set undofile                " So is persistent undo ...
        set undolevels=1000         " Maximum number of changes that can be undone
        set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    endif

    "Save and restore fold state
    au BufWinLeave *.* mkview
    au BufWinEnter *.* silent loadview

    " Add exclusions to mkview and loadview
    " eg: *.*, svn-commit.tmp
    let g:skipview_files = [
        \ '\[example pattern\]'
        \ ]

    " }

" }

" Vim UI {

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode
    set cursorline                  " Highlight current line
    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set relativenumber              " Relative line numbers
    set colorcolumn=85              " Width marker
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set visualbell                  " Flash screen instead of beep
    set wrap                        " Wrap long lines
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:▸\ ,eol:¬,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
    set laststatus=2                " Show status at bottom

    let mapleader=","

" }

" Formatting {

    set textwidth=79                " Try to keep lines from getting too long
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current

    " Remove trailing whitespaces and ^M chars
    " To disable the stripping of whitespace, add the following to your
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()

    "autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    " preceding line best in a plugin but here for now.

    autocmd BufNewFile,BufRead *.coffee set filetype=coffee

    "Show .md with markdown syntax
    autocmd BufNewFile,BufRead *.md set filetype=markdown

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell

" }

" GUI Settings {

    "Set up the GUI
    colorscheme molokai

    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T           " Remove the toolbar
        set lines=40                " 40 lines of text instead of 24
        set columns=120
        if !exists("g:mdb_no_big_font")
            if LINUX() && has("gui_running")
                set guifont=Inconsolata\ for\ Powerline\ 12,Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
            elseif OSX() && has("gui_running")
                set guifont=Inconsolata\ for\ Powerline:h12,Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
            elseif WINDOWS() && has("gui_running")
                set guifont=Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10
            endif
        endif
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
    endif

" }

" Plugin Config {

    " vim-airline {
        " Set configuration options for the statusline plugin vim-airline.
        " See `:echo g:airline_theme_map` for some more choices
        " Default in terminal vim is 'dark'
        if isdirectory(expand("~/.vim/bundle/vim-airline/"))
            let g:airline_powerline_fonts=1
            " Set configuration options for the statusline plugin vim-airline.
            " See `:echo g:airline_theme_map` for some more choices
            " Default in terminal vim is 'dark'
            if has('gui_running')
                let g:airline_theme = 'solarized'
            endif
        endif
    " }

    " NERDTree {
        map <F2> :NERDTreeToggle<CR>
    " }

    " YouCompleteMe {
        " Close autocomplete preview window
        let g:ycm_autoclose_preview_window_after_completion=1
        " use leader g to get to definition
        nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
    " }

    " Syntastic {
        let g:syntastic_python_checkers = ['pylint']
        let g:syntastic_python_pylint_post_args = '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg} [{msg_id}]"'
    " }

" }

" Custom Functions {

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }

    " Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        " To specify a different directory in which to place the vimbackup,
        " vimviews, vimundo, and vimswap files/directories, do it here
        let common_dir = parent . '/.' . prefix

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }

    " Switch quickly between indentations
    nnoremap 2sp :set sw=2 sts=2 ts=2<CR>
    nnoremap 4sp :set sw=4 sts=4 ts=4<CR>

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

" }
