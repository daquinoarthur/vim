syntax on

set shell=/bin/zsh
set noerrorbells
set nomodeline
set ruler
set number
set relativenumber
set nowrap
set clipboard^=unnamed,unnamedplus
set linebreak
set hidden
set expandtab
set splitbelow
set noequalalways
set splitright
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set incsearch
set hlsearch
set ignorecase
set smartcase
set cursorline
set textwidth=80
set cc=60,80,120,160
set lazyredraw

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

set nobackup
set noswapfile
set noundofile
set nowrap
set mouse=a
set spelllang=pt_br,en_us
let mapleader = " "
set timeoutlen=300
set path+=**
set foldmethod=manual
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
set fillchars+=vert:\▏
set fillchars+=eob:\ 
set fillchars+=fold:—
set ttimeout
set ttimeoutlen=10
set ttyfast
set re=0
set virtualedit=

if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' | 
    \   silent execute '!echo -ne "\e[5 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[3 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

if &term =~ '^screen' || &term =~ '^tmux'
    " Handle Ctrl+Arrow keys
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xLeft>=\e[1;*D"
    execute "set <xRight>=\e[1;*C"
endif

" Cursor and display settings
set ttimeoutlen=10

" Word highlighting under cursor
function! HighlightWordUnderCursor()
    if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]'
        let word = expand('<cword>')
        if word != ''
            " Count occurrences of the word in the current buffer
            let word_count = 0
            let save_cursor = getpos(".")
            call cursor(1, 1)
            while search('\V\<'.escape(word, '\').'\>', 'W') > 0
                let word_count += 1
                if word_count > 1
                    break
                endif
            endwhile
            call setpos('.', save_cursor)
            
            " Only highlight if word appears more than once
            if word_count > 1
                exec 'match' 'CursorWord0' '/\V\<'.escape(word, '\').'\>/'
            else
                match none
            endif
        else
            match none
        endif
    else
        match none
    endif
endfunction

autocmd CursorMoved,CursorMovedI * call HighlightWordUnderCursor()
