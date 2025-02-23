" Text Dimmer Plugin
" <leader>h in visual mode: Toggle dimming (toggles off when pressed again)
" <leader>H in visual mode: Focus mode (persists during editing)
" <leader>h or <leader>H in normal mode: Clear dimming

" Initialize variables
let g:text_dimmer_active = 0
let g:text_dimmer_match_id = 0
let g:text_dimmer_original_selection = []
let g:text_dimmer_using_marks = 0
let g:text_dimmer_coc_highlight_disabled = 0
" Buffer-specific dimming states - each buffer can have its own dimming
if !exists('g:text_dimmer_buffer_states')
    let g:text_dimmer_buffer_states = {}
endif

" Define highlight group for dimmed text
highlight DimmedText ctermfg=8 guifg=#2D2E27

" Functions to manage buffer-specific dimming state
function! GetBufferDimmingState()
    let l:bufnr = bufnr('%')
    if !has_key(g:text_dimmer_buffer_states, l:bufnr)
        let g:text_dimmer_buffer_states[l:bufnr] = {
            \ 'active': 0,
            \ 'selection': [],
            \ 'using_marks': 0
            \ }
    endif
    return g:text_dimmer_buffer_states[l:bufnr]
endfunction

function! SetBufferDimmingState(state)
    let l:bufnr = bufnr('%')
    let g:text_dimmer_buffer_states[l:bufnr] = a:state
endfunction

function! ClearBufferDimmingState()
    let l:bufnr = bufnr('%')
    if has_key(g:text_dimmer_buffer_states, l:bufnr)
        unlet g:text_dimmer_buffer_states[l:bufnr]
    endif
endfunction

" Main function to toggle text dimming
function! ToggleTextDimmer() range
    let l:buffer_state = GetBufferDimmingState()
    if l:buffer_state.active
        " Turn off dimming
        call ClearTextDimmer()
    else
        " Turn on dimming
        call ApplyTextDimmer()
    endif
endfunction

" Apply text dimming effect using marks for dynamic updates
function! ApplyTextDimmer()
    " Clear any existing dimming first
    call ClearTextDimmer()
    
    " Disable CoC highlighting to prevent distractions in dimmed areas
    call DisableCocHighlighting()
    
    " Get the current visual selection
    let l:start_line = line("'<")
    let l:end_line = line("'>")
    let l:start_col = col("'<")
    let l:end_col = col("'>")
    
    " Set marks at selection boundaries for dynamic tracking
    call setpos("'s", [0, l:start_line, l:start_col, 0])
    call setpos("'e", [0, l:end_line, l:end_col, 0])
    let g:text_dimmer_using_marks = 1
    
    " Store the selection for later reference
    let g:text_dimmer_original_selection = [l:start_line, l:start_col, l:end_line, l:end_col]
    
    " Store buffer-specific state
    let l:buffer_state = GetBufferDimmingState()
    let l:buffer_state.active = 1
    let l:buffer_state.selection = [l:start_line, l:start_col, l:end_line, l:end_col]
    let l:buffer_state.using_marks = 1
    call SetBufferDimmingState(l:buffer_state)
    
    " Apply the actual dimming patterns
    call ApplyDimmingPatterns(l:start_line, l:start_col, l:end_line, l:end_col)
    let g:text_dimmer_active = 1
endfunction

" Apply dimming patterns based on given coordinates
function! ApplyDimmingPatterns(start_line, start_col, end_line, end_col)
    " Create pattern to match everything EXCEPT the selected text
    let l:total_lines = line('$')
    
    " Dim all lines before the selection start line
    if a:start_line > 1
        let l:before_pattern = '\%<' . a:start_line . 'l.*'
        let l:match_id = matchadd('DimmedText', l:before_pattern)
    endif
    
    " Dim all lines after the selection end line
    if a:end_line < l:total_lines
        let l:after_pattern = '\%>' . a:end_line . 'l.*'
        let l:match_id = matchadd('DimmedText', l:after_pattern)
    endif
    
    " For the lines within the selection range, dim the parts outside the selection
    if a:start_line == a:end_line
        " Single line selection
        if a:start_col > 1
            let l:before_sel = '\%' . a:start_line . 'l\%<' . a:start_col . 'c.'
            let l:match_id = matchadd('DimmedText', l:before_sel)
        endif
        let l:after_sel = '\%' . a:start_line . 'l\%>' . a:end_col . 'c.'
        let l:match_id = matchadd('DimmedText', l:after_sel)
    else
        " Multi-line selection
        " First line: dim before selection start (if selection doesn't start at column 1)
        if a:start_col > 1
            let l:first_line_before = '\%' . a:start_line . 'l\%<' . a:start_col . 'c.'
            let l:match_id = matchadd('DimmedText', l:first_line_before)
        endif
        
        " Last line: dim after selection end
        let l:last_line_after = '\%' . a:end_line . 'l\%>' . a:end_col . 'c.'
        let l:match_id = matchadd('DimmedText', l:last_line_after)
    endif
endfunction

" Update dimming based on current mark positions
function! UpdateTextDimmer()
    let l:buffer_state = GetBufferDimmingState()
    if !l:buffer_state.active || !l:buffer_state.using_marks
        return
    endif
    
    " Get current mark positions
    let l:start_pos = getpos("'s")
    let l:end_pos = getpos("'e")
    
    " Check if marks are still valid
    if l:start_pos[1] == 0 || l:end_pos[1] == 0
        return
    endif
    
    " Clear existing matches and reapply with current positions
    call clearmatches()
    call ApplyDimmingPatterns(l:start_pos[1], l:start_pos[2], l:end_pos[1], l:end_pos[2])
endfunction


" Clear text dimming effect
function! ClearTextDimmer()
    " Clear all DimmedText matches
    call clearmatches()
    let g:text_dimmer_active = 0
    let g:text_dimmer_match_id = 0
    let g:text_dimmer_using_marks = 0
    " Clear buffer-specific state
    call ClearBufferDimmingState()
    " Re-enable CoC highlighting when clearing dimming
    call EnableCocHighlighting()
    " Also clean up marks when manually clearing
    call CleanupTextDimmerMarks()
endfunction

" Clean up text dimmer marks
function! CleanupTextDimmerMarks()
    " Delete the marks we use for tracking selection
    silent! delmarks s e
endfunction

" Disable word highlighting by clearing matches and suspending autocommands
function! DisableCocHighlighting()
    if !g:text_dimmer_coc_highlight_disabled
        " Store current eventignore setting
        let g:text_dimmer_original_eventignore = &eventignore
        
        " Temporarily ignore cursor events that trigger highlighting
        set eventignore+=CursorHold,CursorHoldI,CursorMoved,CursorMovedI
        
        " Clear all existing word highlight matches
        call clearmatches()
        
        " Disable various autocommand groups that handle highlighting
        silent! autocmd! coc_nvim CursorHold
        silent! autocmd! coc_nvim CursorHoldI
        silent! autocmd! coc_nvim CursorMoved
        silent! autocmd! coc_nvim CursorMovedI
        
        " Try to disable CoC document highlighting
        if exists('*CocAction')
            silent! call CocAction('documentHighlight')
        endif
        
        let g:text_dimmer_coc_highlight_disabled = 1
    endif
endfunction

" Re-enable CoC highlighting by restoring autocommands
function! EnableCocHighlighting()
    if g:text_dimmer_coc_highlight_disabled
        " Restore original eventignore setting
        let &eventignore = g:text_dimmer_original_eventignore
        
        " Re-enable CoC highlight autocommands
        augroup coc_nvim
            autocmd CursorHold * silent call CocActionAsync('highlight')
            autocmd CursorHoldI * silent call CocActionAsync('highlight')
        augroup END
        
        let g:text_dimmer_coc_highlight_disabled = 0
    endif
endfunction

" Function to restore dimming state when entering a buffer
function! RestoreBufferDimming()
    let l:buffer_state = GetBufferDimmingState()
    
    " If this buffer has active dimming, restore it
    if l:buffer_state.active && len(l:buffer_state.selection) == 4
        " Clear any existing matches first
        call clearmatches()
        
        " Disable CoC highlighting
        call DisableCocHighlighting()
        
        " Apply dimming patterns using stored coordinates
        let l:selection = l:buffer_state.selection
        call ApplyDimmingPatterns(l:selection[0], l:selection[1], l:selection[2], l:selection[3])
        let g:text_dimmer_active = 1
        let g:text_dimmer_using_marks = l:buffer_state.using_marks
    else
        " No dimming in this buffer, make sure it's clear
        call clearmatches()
        let g:text_dimmer_active = 0
        let g:text_dimmer_using_marks = 0
        " Don't disable CoC highlighting if this buffer doesn't have dimming
        if !l:buffer_state.active
            call EnableCocHighlighting()
        endif
    endif
endfunction

" Handle buffer/window changes - restore buffer-specific dimming state
autocmd BufEnter * call RestoreBufferDimming()
autocmd WinEnter * call RestoreBufferDimming()

" Auto-update dimming when text changes (for focus mode)
autocmd TextChanged * call UpdateTextDimmer()
autocmd TextChangedI * call UpdateTextDimmer()

" Clean up marks when Vim exits
autocmd VimLeave * call CleanupTextDimmerMarks()

" Apply focus mode - persistent dimming that stays during editing
function! ApplyFocusMode()
    " Same as ApplyTextDimmer but designed to persist
    call ApplyTextDimmer()
    echo "Focus mode ON - Press <leader>H to toggle off"
endfunction

" Map <leader>h to toggle text dimming in visual mode (temporary)
vnoremap <leader>h :<C-u>call ToggleTextDimmer()<CR>

" Map <leader>H to apply persistent focus mode in visual mode
vnoremap <leader>H :<C-u>call ApplyFocusMode()<CR>

" Map <leader>h in normal mode to clear dimming
nnoremap <leader>h :call ClearTextDimmer()<CR>

" Map <leader>H in normal mode to clear dimming (same as <leader>h)
nnoremap <leader>H :call ClearTextDimmer()<CR>

" Debug function to identify highlight groups under cursor
function! IdentifyHighlightGroups()
    let l:synid = synID(line('.'), col('.'), 1)
    let l:group_name = synIDattr(l:synid, 'name')
    let l:trans_id = synIDtrans(l:synid)
    let l:trans_name = synIDattr(l:trans_id, 'name')
    
    echo "Cursor position: " . line('.') . "," . col('.')
    echo "Syntax group: " . l:group_name
    echo "Translated group: " . l:trans_name
    echo "Match groups:"
    
    " Get all match groups at cursor position
    let l:matches = getmatches()
    for l:match in l:matches
        echo "  " . l:match.group . " -> " . l:match.pattern
    endfor
    
    return [l:group_name, l:trans_name]
endfunction

" Map to identify highlight groups (for debugging)
nnoremap <leader>d :call IdentifyHighlightGroups()<CR>
