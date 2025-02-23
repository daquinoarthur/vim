" All possible highlighters
" let g:Hexokinase_highlighters = [
" \   'virtual',
" \   'sign_column',
" \   'background',
" \   'backgroundfull',
" \   'foreground',
" \   'foregroundfull'
" \ ]

let g:Hexokinase_highlighters = ['sign_column', 'backgroundfull']

" All possible values
let g:Hexokinase_optInPatterns = [
\     'full_hex',
\     'triple_hex',
\     'rgb',
\     'rgba',
\     'hsl',
\     'hsla',
\     'colour_names'
\ ]

" Filetype specific patterns to match
" entry value must be comma seperated list
let g:Hexokinase_ftOptInPatterns = {
\     'css': 'triple_hex, full_hex,rgb,rgba,hsl,hsla',
\     'html': 'triple_hex, full_hex,rgb,rgba,hsl,hsla',
\     'text': 'triple_hex, full_hex,rgb,rgba,hsl,hsla',
\     'javascript': 'triple_hex, full_hex,rgb,rgba,hsl,hsla',
\     'javascriptreact': 'triple_hex, full_hex,rgb,rgba,hsl,hsla',
\     'typescript': 'triple_hex, full_hex,rgb,rgba,hsl,hsla',
\     'typescriptreact': 'triple_hex, full_hex,rgb,rgba,hsl,hsla',
\     'dosini': 'triple_hex, full_hex,rgb,rgba,hsl,hsla',
\     'sh': 'triple_hex, full_hex,rgb,rgba,hsl,hsla',
\     'vim': 'triple_hex, full_hex,rgb,rgba,hsl,hsla',
\     'json': 'triple_hex, full_hex,rgb,rgba,hsl,hsla',
\     'jsonc': 'triple_hex full_hex,rgb,rgba,hsl,hsla',
\     'git': 'triple_hex full_hex,rgb,rgba,hsl,hsla',
\     '': 'triple_hex full_hex,rgb,rgba,hsl,hsla'
\ }

" Sample value, to keep default behaviour don't define this variable
let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vim', 'json', 'jsonc']
