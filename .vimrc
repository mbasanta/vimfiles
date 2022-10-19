" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:
"
"   This is the personal .vimrc file of Matthew Basanta. 
"
"   Copyright 2022 Matthew Basanta
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

set number
set relativenumber " relative line number
set splitright
set splitbelow
set autoindent expandtab tabstop=4 shiftwidth=4 softtabstop=4 " set up tabs

set laststatus=2 " show status line

" Set up cursor for windows terminal
if &term =~ '^xterm'
    " Cursor in terminal:
    " Link: https://vim.fandom.com/wiki/Configuring_the_cursor
    " 0 -> blinking block not working in wsl
    " 1 -> blinking block
    " 2 -> solid block
    " 3 -> blinking underscore
    " 4 -> solid underscore
    " Recent versions of xterm (282 or above) also support
    " 5 -> blinking vertical bar
    " 6 -> solid vertical bar

    " normal mode
    let &t_EI .= "\e[1 q"
    " insert mode
    let &t_SI .= "\e[5 q"

    augroup windows_term
        autocmd!
        autocmd VimEnter * silent !echo -ne "\e[1 q"
        autocmd VimLeave * silent !echo -ne "\e[5 q"
    augroup END
    endif

"Fonts for the Status Line
let g:airline_powerline_fonts = 1
