
" Tokyo Night FZF Configuration with Transparent Backgrounds
" Define custom highlight groups for FZF with transparent backgrounds
highlight FzfBg guibg=NONE ctermbg=NONE
highlight FzfBgPlus guibg=NONE ctermbg=NONE

let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'FzfBg'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'FzfBgPlus'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Override specific highlights to ensure transparency
autocmd VimEnter * highlight CursorLine guibg=NONE ctermbg=NONE
autocmd VimEnter * highlight CursorColumn guibg=NONE ctermbg=NONE
autocmd VimEnter * highlight FzfBg guibg=NONE ctermbg=NONE
autocmd VimEnter * highlight FzfBgPlus guibg=NONE ctermbg=NONE

" Modified Rg command with clipboard support
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({
  \     'options': '--multi --expect=ctrl-y --layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"',
  \     'sink*': function('RgSink')
  \   }, 'right:50%'),
  \   <bang>0)

" Modified Rgi command with clipboard support
command! -bang -nargs=* Rgi
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({
  \     'options': '--multi --expect=ctrl-y --layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"',
  \     'sink*': function('RgSink')
  \   }, 'right:50%'),
  \   <bang>0)

" Modified Rgic command with clipboard support
command! -bang -nargs=* Rgic
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({
  \     'options': '--multi --expect=ctrl-y --layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"',
  \     'sink*': function('RgSink')
  \   }, 'right:50%'),
  \   <bang>0)

" Modified Rgir command with clipboard support
command! -bang -nargs=* Rgir
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({
  \     'options': '--multi --expect=ctrl-y --layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"',
  \     'sink*': function('RgSink')
  \   }, 'right:50%'),
  \   <bang>0)

" Modified Rgr command with clipboard support
command! -bang -nargs=* Rgr
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --hidden --no-ignore --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({
  \     'options': '--multi --expect=ctrl-y --layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"',
  \     'sink*': function('RgSink')
  \   }, 'right:50%'),
  \   <bang>0)

" Modified BLines command with clipboard support
command! -bang -nargs=* BLines
  \ call fzf#vim#grep(
  \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
  \   fzf#vim#with_preview({
  \     'options': '--multi --expect=ctrl-y --layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"',
  \     'sink*': function('RgSink')
  \   }, 'right:50%'))

" RgSink function to handle clipboard operations and quickfix
function! RgSink(lines)
  if len(a:lines) < 2
    return
  endif
  let key = remove(a:lines, 0)
  if key == 'ctrl-y'
    let content = join(map(a:lines, 'split(v:val, ":")[-1]'), "\n")
    call setreg('*', content)
    echo "Copied to clipboard"
  else
    let qf_list = []
    for line in a:lines
      let parts = split(line, ':')
      let entry = {'filename': parts[0], 'lnum': parts[1], 'col': parts[2], 'text': join(parts[3:], ':')}
      call add(qf_list, entry)
    endfor
    call setqflist(qf_list, 'r')
    " Open the quickfix window only if multiple lines are selected
    if len(a:lines) > 1
      copen
    else
      " Open the file directly if only one line is selected
      let parts = split(a:lines[0], ':')
      execute 'edit' fnameescape(parts[0])
      execute parts[1]
      execute 'normal!' parts[2].'|'
    endif
  endif
endfunction

" First, declare the debug log file path as a script variable
let s:debug_log = '/tmp/vim_debug.log'

" Debug function to log messages to a file
function! s:LogDebug(message)
  silent! call writefile([strftime('%H:%M:%S') . ': ' . a:message], s:debug_log, 'a')
endfunction

" Function to safely execute system commands
function! s:SafeSystem(cmd)
  try
    call s:LogDebug('Executing command: ' . a:cmd)
    let output = system(a:cmd)
    call s:LogDebug('Command output: ' . output)
    return output
  catch
    call s:LogDebug('Error executing command: ' . v:exception)
    return ''
  endtry
endfunction

" Function to find existing path in project
function! s:FindProjectPath(path_components)
  try
    " Get project root
    let root = s:SafeSystem('git rev-parse --show-toplevel 2>/dev/null')
    let root = substitute(root, '\n$', '', '')
    
    if empty(root)
      let root = getcwd()
    endif
    call s:LogDebug('Project root: ' . root)

    " Build the search path
    let search_base = join(a:path_components[0:0], '/')
    call s:LogDebug('Searching for base path: ' . search_base)

    " Search for the directory
    let find_cmd = 'find ' . root . ' -type d -path "*/src/*/' . search_base . '" 2>/dev/null'
    let found = s:SafeSystem(find_cmd)
    let paths = split(found, '\n')
    
    call s:LogDebug('Found paths: ' . string(paths))
    
    return len(paths) > 0 ? paths[0] : ''
  catch
    call s:LogDebug('Error in FindProjectPath: ' . v:exception)
    return ''
  endtry
endfunction

" Main file handling function
function! s:HandleFileSelection(lines)
  try
    call s:LogDebug('Starting HandleFileSelection with input: ' . string(a:lines))
    
    if len(a:lines) < 1
      return
    endif

    let query = a:lines[0]
    let file_path = len(a:lines) > 2 ? a:lines[2] : query
    let file_path = substitute(file_path, '^\.\/', '', '')
    call s:LogDebug('Processing file path: ' . file_path)

    if empty(file_path)
      return
    endif

    if filereadable(file_path)
      execute 'edit' fnameescape(file_path)
      return
    endif

    let create = input("File '" . file_path . "' doesn't exist. Create it? (y/n): ")
    if create ==? 'y'
      let path_components = split(file_path, '/')
      let filename = path_components[-1]
      let dir_components = path_components[:-2]
      
      call s:LogDebug('Path components: ' . string(path_components))

      let base_path = s:FindProjectPath(dir_components)
      call s:LogDebug('Found base path: ' . base_path)

      if !empty(base_path)
        let full_path = base_path
        for component in dir_components[1:]
          let full_path .= '/' . component
          if !isdirectory(full_path)
            call s:LogDebug('Creating directory: ' . full_path)
            call mkdir(full_path, 'p')
          endif
        endfor

        let new_file_path = full_path . '/' . filename
        call s:LogDebug('Creating file at: ' . new_file_path)
        
        execute 'edit' fnameescape(new_file_path)
        write
        echo "Created file:" new_file_path
      else
        call s:LogDebug('No existing path found, creating in current directory')
        let dir = fnamemodify(file_path, ':h')
        if dir != '.' && !isdirectory(dir)
          call mkdir(dir, 'p')
        endif
        execute 'edit' fnameescape(file_path)
        write
      endif
    endif
  catch
    call s:LogDebug('Error in HandleFileSelection: ' . v:exception)
    echo "Error occurred. Check /tmp/vim_debug.log for details."
  endtry
endfunction

" Modified MyFiles function
function! MyFiles(dir)
  try
    call s:LogDebug('Starting MyFiles with dir: ' . a:dir)
    let original_dir = getcwd()
    
    if !empty(a:dir)
      execute 'cd' a:dir
    endif

    call fzf#vim#files('.',
          \ {'options': '--print-query --prompt "File> "',
          \  'sink*': function('s:HandleFileSelection')})

    if !empty(a:dir)
      execute 'cd' original_dir
    endif
  catch
    call s:LogDebug('Error in MyFiles: ' . v:exception)
    echo "Error occurred. Check /tmp/vim_debug.log for details."
  endtry
endfunction

command! -nargs=? -complete=dir CustomFiles call MyFiles(<q-args>)
