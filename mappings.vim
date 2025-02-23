"Buffer navigation
nnoremap <silent> <Tab> <Plug>vem_next_buffer-
nnoremap <silent> <S-Tab> <Plug>vem_prev_buffer-

" Buffer management
nnoremap <silent> <leader>bc :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <silent> <leader>ba :w <bar> %bd <bar> e# <bar> bd# <CR>
nnoremap <silent> <leader>bq :bd!<CR>

" FZF mappings
nnoremap <leader>ff :Files<CR>
nnoremap <leader>nf :CustomFiles<CR>
nnoremap <leader>fa :Rgi<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>m :Marks<CR>

" Utility mappings
nnoremap <silent> <leader>h :helptags ~/.vim/doc<CR>
nnoremap <silent> <leader>nh :noh<CR>

" Vim-narrow mappings
nnoremap <silent> <leader>n :Narrow<CR>
vnoremap <silent> <leader>n :Narrow<CR>
nnoremap <silent> <leader>w :Widen<CR>

" Vista mappings
nnoremap <silent> <leader>v :Vista!!<CR>
nnoremap <silent> <leader>vf :Vista finder<CR>

" Git mappings
nnoremap <silent> <leader>gf :!clear && git-foresta \| less<CR>
nnoremap <silent> <leader>gc :!zsh -ic fshow<CR>
nnoremap <silent> <leader>gsh :!clear && git show<CR>
nnoremap <silent> <leader>gd :!clear && git diff %<CR>
nnoremap <silent> <leader>gda :!clear && git diff<CR>
nnoremap <silent> <leader>gl :vertical Git log --oneline<CR>

" Todos
nnoremap <silent> <leader>td :Todos<CR>

" DB UI
nnoremap <silent> <leader>dt :DBUIToggle<CR>

" Window resizing
nnoremap <silent> <Up> :resize -2<CR>
nnoremap <silent> <Down> :resize +2<CR>
nnoremap <silent> <Left> :vertical resize -2<CR>
nnoremap <silent> <Right> :vertical resize +2<CR>

" Marks management
nnoremap <silent> <leader>dm :delmarks a-zA-Z<CR>

" Search and show
nnoremap <leader>fn :vimgrep //g %<CR>:copen<CR>
function! SearchAndShow()
    let search_term = input("Search: ")
    if search_term != ''
        let @/ = search_term
        " Clear any existing error messages
        let v:errmsg = ''
        try
            " Perform the search
            execute 'vimgrep /'.escape(search_term, '/').'/ %'
            " Check if vimgrep produced any errors
            if v:errmsg != ''
                throw "SearchError"
            endif
            " Get the quickfix list and check for matches
            let qf_list = getqflist()
            if len(qf_list) > 0
                copen
                redraw
                echo ""  | " Clear the command line
            else
                throw "NoMatches"
            endif
        catch /E480/  " Catch the specific 'No match' error from vimgrep
            redraw
            echohl WarningMsg
            echo "No matches found for '" . search_term . "'"
            echohl None
        catch /SearchError/
            redraw
            echohl WarningMsg
            echo "An error occurred during the search: " . v:errmsg
            echohl None
        endtry
    endif
endfunction
nnoremap <leader>fs :call SearchAndShow()<CR>

" Remove empty lines
nnoremap <leader>re :%g/^\s*$/d<CR>
xnoremap <leader>re :g/^\s*$/d<CR>       

" Map key to translate the word under cursor to English
nnoremap <leader>te :execute '!clear && translatetoen ' . expand('<cword>')<CR>
vnoremap <leader>te "zy:execute '!clear && translatetoen "' . shellescape(@z) . '"'<CR>

" Map key to translate the word under cursor to Spanish
nnoremap <leader>ts :execute '!clear && translatetoes ' . expand('<cword>')<CR>
vnoremap <leader>ts "zy:execute '!clear && translatetoes "' . shellescape(@z) . '"'<CR>

" Map key to translate the word under cursor to Portuguese
nnoremap <leader>tp :execute '!clear && translatetopt ' . expand('<cword>')<CR>
vnoremap <leader>tp "zy:execute '!clear && translatetopt "' . shellescape(@z) . '"'<CR>


" Run python code directly from vim
function! ExecutePythonLine()
    let tmp_file = '/tmp/vim_python_exec.py'
    call writefile([getline('.')], tmp_file)
    execute '!clear && python3' tmp_file
endfunction

function! ExecutePythonVisual() range
    let tmp_file = '/tmp/vim_python_exec.py'
    let lines = getline(a:firstline, a:lastline)
    call writefile(lines, tmp_file)
    execute '!clear && python3' tmp_file
endfunction

nnoremap <leader>rp :call ExecutePythonLine()<CR>
xnoremap <leader>rp :call ExecutePythonVisual()<CR>
nnoremap <leader>rf :!clear && python3 %<CR>

" Run python test under cursor
function! RunTestUnderCursor()
    " Find the nearest test function definition above cursor
    let l:func_pattern = '\v^\s*def \w+'
    let l:func_lnum = search(l:func_pattern, 'bcnW')
    if l:func_lnum == 0
        echo "No test function found"
        return
    endif
    " Extract test method name from the function definition line
    let l:func_line = getline(l:func_lnum)
    let l:test_name = matchstr(l:func_line, '\vdef \zs\w+\ze\(')
    if empty(l:test_name)
        echo "No test found"
        return
    endif
    " Get the test class name
    let l:class_pattern = '\v^\s*class\s+\zs\w+\ze'
    let l:class_lnum = search(l:class_pattern, 'bnW')
    let l:class_name = matchstr(getline(l:class_lnum), l:class_pattern)
    " Get file name without .py extension
    let l:file = expand('%:t:r')
    " Construct and execute the test command
    let l:cmd = 'clear && python -m unittest ' . l:file . '.' . l:class_name . '.' . l:test_name
    execute '!' . l:cmd
endfunction

" Map <leader>t to run test under cursor
nnoremap <leader>ur :call RunTestUnderCursor()<CR>
nnoremap <leader>uf :!clear && python -m unittest %<CR>

" Run pytest test under cursor
function! RunPytestUnderCursor()
    " Find the nearest test function definition above cursor
    let l:func_pattern = '\v^\s*def \w+'
    let l:func_lnum = search(l:func_pattern, 'bcnW')
    if l:func_lnum == 0
        echo "No test function found"
        return
    endif
    " Extract test method name from the function definition line
    let l:func_line = getline(l:func_lnum)
    let l:test_name = matchstr(l:func_line, '\vdef \zs\w+\ze\(')
    if empty(l:test_name)
        echo "No test found"
        return
    endif
    " Get the test class name
    let l:class_pattern = '\v^\s*class\s+\zs\w+\ze'
    let l:class_lnum = search(l:class_pattern, 'bnW')
    let l:class_name = matchstr(getline(l:class_lnum), l:class_pattern)
    " Get full file path
    let l:file_path = expand('%:p')
    " Construct and execute the test command
    let l:cmd = 'clear && pytest ' . l:file_path . '::' . l:class_name . '::' . l:test_name . ' -v -vv -s'
    execute '!' . l:cmd
endfunction

" Map <leader>pt to run pytest test under cursor
" nnoremap <leader>pr :call RunPytestUnderCursor()<CR>
" nnoremap <leader>pf :!clear && pytest % -v -vv -s<CR>
" nnoremap <leader>pa :!clear && pytest -v -vv -s<CR>

" Update Plugins in Vim
nnoremap <leader>up :PlugUpdate<CR>

" Prep step: let Vim change its title-string when in Normal mode (with limitation)
" Will update the trailing `n` to `i` when switched from normal mode to insert mode.
setglobal titlestring=%F\ %{v:servername}\ %{mode()}
 
" Removing <Tab> from vimwiki mappings
" Core step: <Tab> and <c-i> tweak
nmap <F21> <Plug>VimwikiNextLink
nmap <F22> <Plug>VimwikiPrevLink
set wildcharm=<Tab>
cmap <F12> <c-i>

nnoremap <silent> <leader>rc :!clear && coverage run -m pytest --no-migrations -s -v -vv && coverage report -m<CR>

" Oil 
nmap <leader>x :Oil<CR>

" Coc Explorer
nmap <leader>ri :CocCommand editor.action.organizeImport<CR>

nmap <leader>oi :CocCommand editor.action.organizeImport<CR>

" Makes it quick to run shell commands from vim
nmap ! :!clear && 

" Run pieces of Python code and outputs on a split window
function! RunCodeInSplit() range
  let lines = getline(a:firstline, a:lastline)
  let code = join(lines, "\n")
  let tmpfile = tempname()
  let java_tmpfile = ''
  
  " Detect language from code content
  if code =~ '\v(class\s+\w+|public\s+(static\s+)?void\s+main|System\.out\.println|public\s+\w+\s+\w+\s*\()'
    " Find the main class name
    let main_classname = matchstr(code, '\v(public\s+class\s+|class\s+)\zs\w+\ze.*\{.*main\s*\(')
    if empty(main_classname)
      let main_classname = 'Main'
      let code = 'public class Main { public static void main(String[] args) { ' . code . ' } }'
    else
      " If there's a class but no main method, wrap execution code in main
      if code !~ '\v(public\s+static\s+void\s+main|static\s+public\s+void\s+main)'
        " Split class definition from execution code
        let lines = split(code, "\n")
        let class_lines = []
        let exec_lines = []
        let in_class = 0
        let brace_count = 0
        
        for line in lines
          if line =~ '\v^\s*class\s+'
            let in_class = 1
          endif
          
          if in_class
            call add(class_lines, line)
            let brace_count += len(substitute(line, '[^{]', '', 'g'))
            let brace_count -= len(substitute(line, '[^}]', '', 'g'))
            if brace_count == 0 && line =~ '}'
              let in_class = 0
            endif
          else
            if line !~ '^\s*$'
              call add(exec_lines, line)
            endif
          endif
        endfor
        
        " Reconstruct code with main method
        if len(exec_lines) > 0
          let code = join(class_lines, "\n") . "\n\npublic class Main {\n  public static void main(String[] args) {\n    " . join(exec_lines, "\n    ") . "\n  }\n}"
          let main_classname = 'Main'
        else
          let code = join(class_lines, "\n")
        endif
      endif
    endif
    " Create correctly named Java file
    let java_tmpfile = '/tmp/' . main_classname . '.java'
    let cmd = 'cd /tmp && javac ' . main_classname . '.java && java ' . main_classname
  elseif code =~ '\v(import\s+\w+|from\s+\w+\s+import|def\s+\w+|print\s*\(|\.append\s*\()'
    let cmd = 'python3'
  elseif code =~ '\v(console\.log|require\s*\(|function\s+\w+|const\s+\w+|let\s+\w+|var\s+\w+)'
    let cmd = 'node'
  elseif code =~ '\v(puts\s+|def\s+\w+|class\s+\w+|require\s+)'
    let cmd = 'ruby'
  elseif code =~ '\v(echo\s+|if\s+\[|for\s+\w+\s+in|#!/bin/(ba)?sh)'
    let cmd = 'bash'
  elseif code =~ '\v(package\s+main|func\s+\w+|import\s+\")'
    let tmpfile = tmpfile . '.go'
    let cmd = 'go run'
  elseif code =~ '\v(fn\s+\w+|let\s+mut|println!|use\s+std::)'
    let tmpfile = tmpfile . '.rs'
    let cmd = 'rustc -o /tmp/rust_exec && /tmp/rust_exec'
  elseif code =~ '\v(\$\w+|echo\s+\$|if\s+\[\[)'
    let cmd = 'zsh'
  elseif code =~ '\v(<?php|echo\s+\"|print\s+\")'
    let cmd = 'php'
  elseif code =~ '\v(print\s*\(|function\s+\w+\s*\(|local\s+\w+)'
    let cmd = 'lua'
  else
    " Fallback: ask user to specify language
    let lang = input('Language (python/node/ruby/bash/go/rust/zsh/php/lua/java): ')
    if lang == 'python'
      let cmd = 'python3'
    elseif lang == 'node' || lang == 'javascript' || lang == 'js'
      let cmd = 'node'
    elseif lang == 'ruby'
      let cmd = 'ruby'
    elseif lang == 'bash' || lang == 'sh'
      let cmd = 'bash'
    elseif lang == 'go'
      let tmpfile = tmpfile . '.go'
      let cmd = 'go run'
    elseif lang == 'rust'
      let tmpfile = tmpfile . '.rs'
      let cmd = 'rustc -o /tmp/rust_exec && /tmp/rust_exec'
    elseif lang == 'zsh'
      let cmd = 'zsh'
    elseif lang == 'php'
      let cmd = 'php'
    elseif lang == 'lua'
      let cmd = 'lua'
    elseif lang == 'java'
      let classname = 'Main'
      let code = 'public class Main { public static void main(String[] args) { ' . code . ' } }'
      let java_tmpfile = '/tmp/' . classname . '.java'
      let cmd = 'cd /tmp && javac ' . classname . '.java && java ' . classname
    else
      echo 'Unsupported language: ' . lang
      return
    endif
  endif
  
  " Write code to temporary file and execute
  if java_tmpfile != ''
    " Java needs special file naming
    call writefile(split(code, "\n"), java_tmpfile)
    let output = system('(' . cmd . ') 2>&1')
    call writefile(split(output, "\n"), tmpfile . '_output')
  else
    " Other languages use regular temp file
    call writefile(split(code, "\n"), tmpfile)
    let output = system('(' . cmd . ' ' . tmpfile . ') 2>&1')
    call writefile(split(output, "\n"), tmpfile . '_output')
  endif
  
  execute 'split ' . tmpfile . '_output'
endfunction
vnoremap <leader>e :call RunCodeInSplit()<CR>
