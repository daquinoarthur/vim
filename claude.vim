let g:claude_api_key = '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'

" Ensure markdown syntax is loaded
au BufNewFile,BufRead *.md set filetype=markdown

" Define markdownCodeBlock highlight group if it doesn't exist
if !hlexists("markdownCodeBlock")
  highlight link markdownCodeBlock String
endif
