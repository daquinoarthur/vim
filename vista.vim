let g:vista#renderer#enable_icon = 0
let g:vista_icon_indent = ["╰─> ", "├─> "]
let g:vista_sidebar_width = 50

" Use COC for React files
let g:vista_executive_for = {
  \ 'javascript': 'coc',
  \ 'javascriptreact': 'coc', 
  \ 'typescript': 'coc',
  \ 'typescriptreact': 'coc',
  \ }

" Enable automatic updates
let g:vista_update_on_text_changed = 1
let g:vista_update_on_text_changed_delay = 500

" Show current symbol in statusline
let g:vista_echo_cursor = 1
