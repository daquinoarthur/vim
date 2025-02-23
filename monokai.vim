" Monokai Configuration with Transparent Backgrounds
" Converted from Tokyo Night to classic Monokai

set termguicolors

" Apply Monokai colorscheme
colorscheme monokai

" Override specific highlights to maintain transparency and your preferred styling
augroup MonokaiCustom
    autocmd!
    " Ensure transparent backgrounds for main interface elements
    autocmd ColorScheme monokai hi Normal guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi NonText guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi EndOfBuffer guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi SignColumn guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi FoldColumn guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi Folded guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi VertSplit guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi StatusLine guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi StatusLineNC guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi StatusLineTerm guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi StatusLineTermNC guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi Tabline guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi TablineFill guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi TablineSel guibg=NONE ctermbg=NONE guifg=#A6E22E ctermfg=118 gui=bold cterm=bold
    
    " Line numbers with transparent background
    autocmd ColorScheme monokai hi LineNr guibg=NONE ctermbg=NONE guifg=#75715E ctermfg=242
    
    " Completion menu transparency
    autocmd ColorScheme monokai hi Pmenu guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi PmenuSel guibg=#49483E ctermbg=238
    
    " Floating windows
    autocmd ColorScheme monokai hi NormalFloat guibg=#272822 ctermbg=235
    
    " COC.NVIM integration with subtle background for selected items
    autocmd ColorScheme monokai hi CocPumMenu guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi CocPumSearch guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi CocMenuSel guibg=#49483E ctermbg=238
    autocmd ColorScheme monokai hi CocPum guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi CocPumSel guibg=#49483E ctermbg=238
    autocmd ColorScheme monokai hi CocMenu guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi CocPumFloating guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi CocPumVirtualText guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi CocPumDetail guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi CocPumShortcut guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi CocListLine guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi CocListMode guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi CocListPath guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi FgCocListMode guibg=NONE ctermbg=NONE
    
    " Remove underlines from COC diagnostic highlights
    autocmd ColorScheme monokai hi CocUnusedHighlight guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    autocmd ColorScheme monokai hi CocDeprecatedHighlight guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    autocmd ColorScheme monokai hi CocErrorHighlight guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    autocmd ColorScheme monokai hi CocWarningHighlight guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    autocmd ColorScheme monokai hi CocInfoHighlight guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    autocmd ColorScheme monokai hi CocHintHighlight guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    autocmd ColorScheme monokai hi CocCodeLens guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    autocmd ColorScheme monokai hi CocInlayHint guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    
    " Subtle semantic highlighting - remove bold and use gentle background
    autocmd ColorScheme monokai hi CocHighlightText guifg=NONE guibg=#49483E ctermbg=238 gui=NONE cterm=NONE
    autocmd ColorScheme monokai hi CocHighlightRead guifg=NONE guibg=#49483E ctermbg=238 gui=NONE cterm=NONE
    autocmd ColorScheme monokai hi CocHighlightWrite guifg=NONE guibg=#49483E ctermbg=238 gui=NONE cterm=NONE
    
    " COC signs with transparent backgrounds
    autocmd ColorScheme monokai hi CocErrorSign guibg=NONE ctermbg=NONE guifg=#F92672 ctermfg=197
    autocmd ColorScheme monokai hi CocWarningSign guibg=NONE ctermbg=NONE guifg=#E6DB74 ctermfg=228
    autocmd ColorScheme monokai hi CocInfoSign guibg=NONE ctermbg=NONE guifg=#66D9EF ctermfg=81
    autocmd ColorScheme monokai hi CocHintSign guibg=NONE ctermbg=NONE guifg=#A6E22E ctermfg=118
    
    " Additional diagnostic signs (for other LSP clients or plugins)
    autocmd ColorScheme monokai hi DiagnosticSignError guibg=NONE ctermbg=NONE guifg=#F92672 ctermfg=197
    autocmd ColorScheme monokai hi DiagnosticSignWarn guibg=NONE ctermbg=NONE guifg=#E6DB74 ctermfg=228
    autocmd ColorScheme monokai hi DiagnosticSignInfo guibg=NONE ctermbg=NONE guifg=#66D9EF ctermfg=81
    autocmd ColorScheme monokai hi DiagnosticSignHint guibg=NONE ctermbg=NONE guifg=#A6E22E ctermfg=118
    
    " LSP diagnostic signs (alternative names)
    autocmd ColorScheme monokai hi LspDiagnosticsSignError guibg=NONE ctermbg=NONE guifg=#F92672 ctermfg=197
    autocmd ColorScheme monokai hi LspDiagnosticsSignWarning guibg=NONE ctermbg=NONE guifg=#E6DB74 ctermfg=228
    autocmd ColorScheme monokai hi LspDiagnosticsSignInformation guibg=NONE ctermbg=NONE guifg=#66D9EF ctermfg=81
    autocmd ColorScheme monokai hi LspDiagnosticsSignHint guibg=NONE ctermbg=NONE guifg=#A6E22E ctermfg=118
    
    " ALE signs (if using ALE plugin)
    autocmd ColorScheme monokai hi ALEErrorSign guibg=NONE ctermbg=NONE guifg=#F92672 ctermfg=197
    autocmd ColorScheme monokai hi ALEWarningSign guibg=NONE ctermbg=NONE guifg=#E6DB74 ctermfg=228
    autocmd ColorScheme monokai hi ALEInfoSign guibg=NONE ctermbg=NONE guifg=#66D9EF ctermfg=81
    
    " Git integration transparency with proper colors
    autocmd ColorScheme monokai hi GitGutterAdd guibg=NONE ctermbg=NONE guifg=#A6E22E ctermfg=118
    autocmd ColorScheme monokai hi GitGutterChange guibg=NONE ctermbg=NONE guifg=#E6DB74 ctermfg=228
    autocmd ColorScheme monokai hi GitGutterDelete guibg=NONE ctermbg=NONE guifg=#F92672 ctermfg=197
    autocmd ColorScheme monokai hi GitGutterChangeDelete guibg=NONE ctermbg=NONE guifg=#AE81FF ctermfg=141
    
    autocmd ColorScheme monokai hi SignifySignAdd guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi SignifySignChange guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi SignifySignDelete guibg=NONE ctermbg=NONE
    
    " Marks & signs transparency
    autocmd ColorScheme monokai hi SignatureMarkText guibg=NONE ctermbg=NONE
    autocmd ColorScheme monokai hi SignatureMarkerText guibg=NONE ctermbg=NONE
    
    " Subtle search highlighting
    autocmd ColorScheme monokai hi Search guifg=#F8F8F2 guibg=#49483E ctermbg=238 ctermfg=251 gui=NONE cterm=NONE
    autocmd ColorScheme monokai hi IncSearch guifg=#272822 guibg=#AE81FF ctermbg=140 ctermfg=235 gui=NONE cterm=NONE
    
    " Cursor line with transparent background
    autocmd ColorScheme monokai hi CursorLine guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    " Purple line number on cursor line
    autocmd ColorScheme monokai hi CursorLineNr guifg=#AE81FF guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    
    " Word occurrence highlighting with subtle background
    autocmd ColorScheme monokai hi CursorWord0 guifg=NONE guibg=#49483E ctermbg=240 gui=NONE cterm=NONE
    autocmd ColorScheme monokai hi CursorWord1 guifg=NONE guibg=#49483E ctermbg=240 gui=NONE cterm=NONE
    autocmd ColorScheme monokai hi WordUnderCursor guifg=NONE guibg=#49483E ctermbg=240 gui=NONE cterm=NONE
    autocmd ColorScheme monokai hi MatchWord guifg=NONE guibg=#49483E ctermbg=240 gui=NONE cterm=NONE
augroup END

" Apply the initial customizations
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE
hi FoldColumn guibg=NONE ctermbg=NONE
hi Folded guibg=NONE ctermbg=NONE
hi VertSplit guibg=NONE ctermbg=NONE
hi StatusLine guibg=NONE ctermbg=NONE
hi StatusLineNC guibg=NONE ctermbg=NONE
hi StatusLineTerm guibg=NONE ctermbg=NONE
hi StatusLineTermNC guibg=NONE ctermbg=NONE
hi Tabline guibg=NONE ctermbg=NONE
hi TablineFill guibg=NONE ctermbg=NONE
hi TablineSel guibg=NONE ctermbg=NONE guifg=#AE81FF ctermfg=140 gui=bold cterm=bold

" Line numbers with transparent background
hi LineNr guibg=NONE ctermbg=NONE guifg=#75715E ctermfg=242

" Completion menu transparency with subtle selection background
hi Pmenu guibg=NONE ctermbg=NONE
hi PmenuSel guibg=#49483E ctermbg=238

" COC completion with subtle background for selected item
hi CocPumMenu guibg=NONE ctermbg=NONE
hi CocPumSel guibg=#49483E ctermbg=238
hi CocMenuSel guibg=#49483E ctermbg=238
hi CocPum guibg=NONE ctermbg=NONE
hi CocMenu guibg=NONE ctermbg=NONE
hi CocPumFloating guibg=NONE ctermbg=NONE

" Git signs transparency with proper colors
hi GitGutterAdd guibg=NONE ctermbg=NONE guifg=#A6E22E ctermfg=118
hi GitGutterChange guibg=NONE ctermbg=NONE guifg=#E6DB74 ctermfg=228
hi GitGutterDelete guibg=NONE ctermbg=NONE guifg=#F92672 ctermfg=197
hi GitGutterChangeDelete guibg=NONE ctermbg=NONE guifg=#AE81FF ctermfg=141

" Diagnostic signs transparency with Monokai colors
hi CocErrorSign guibg=NONE ctermbg=NONE guifg=#F92672 ctermfg=197
hi CocWarningSign guibg=NONE ctermbg=NONE guifg=#E6DB74 ctermfg=228
hi CocInfoSign guibg=NONE ctermbg=NONE guifg=#66D9EF ctermfg=81
hi CocHintSign guibg=NONE ctermbg=NONE guifg=#A6E22E ctermfg=118

hi DiagnosticSignError guibg=NONE ctermbg=NONE guifg=#F92672 ctermfg=197
hi DiagnosticSignWarn guibg=NONE ctermbg=NONE guifg=#E6DB74 ctermfg=228
hi DiagnosticSignInfo guibg=NONE ctermbg=NONE guifg=#66D9EF ctermfg=81
hi DiagnosticSignHint guibg=NONE ctermbg=NONE guifg=#A6E22E ctermfg=118

hi LspDiagnosticsSignError guibg=NONE ctermbg=NONE guifg=#F92672 ctermfg=197
hi LspDiagnosticsSignWarning guibg=NONE ctermbg=NONE guifg=#E6DB74 ctermfg=228
hi LspDiagnosticsSignInformation guibg=NONE ctermbg=NONE guifg=#66D9EF ctermfg=81
hi LspDiagnosticsSignHint guibg=NONE ctermbg=NONE guifg=#A6E22E ctermfg=118

hi ALEErrorSign guibg=NONE ctermbg=NONE guifg=#F92672 ctermfg=197
hi ALEWarningSign guibg=NONE ctermbg=NONE guifg=#E6DB74 ctermfg=228
hi ALEInfoSign guibg=NONE ctermbg=NONE guifg=#66D9EF ctermfg=81

" Subtle search highlighting
hi Search guifg=#F8F8F2 guibg=#49483E ctermbg=238 ctermfg=251 gui=NONE cterm=NONE
hi IncSearch guifg=#272822 guibg=#AE81FF ctermbg=140 ctermfg=235 gui=NONE cterm=NONE

" Cursor line with transparent background
hi CursorLine guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" Purple line number on cursor line
hi CursorLineNr guifg=#AE81FF guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" Word occurrence highlighting with subtle background
hi CursorWord0 guifg=NONE guibg=#49483E ctermbg=240 gui=NONE cterm=NONE
hi CursorWord1 guifg=NONE guibg=#49483E ctermbg=240 gui=NONE cterm=NONE
hi WordUnderCursor guifg=NONE guibg=#49483E ctermbg=240 gui=NONE cterm=NONE
hi MatchWord guifg=NONE guibg=#49483E ctermbg=240 gui=NONE cterm=NONE

" Subtle semantic highlighting - remove bold and use gentle background  
hi CocHighlightText guifg=NONE guibg=#49483E ctermbg=238 gui=NONE cterm=NONE
hi CocHighlightRead guifg=NONE guibg=#49483E ctermbg=238 gui=NONE cterm=NONE
hi CocHighlightWrite guifg=NONE guibg=#49483E ctermbg=238 gui=NONE cterm=NONE

" Remove cursor underline in NERDTree and Plug
augroup MonokaiCursorFix
    autocmd!
    autocmd FileType nerdtree setlocal nocursorline
    autocmd FileType nerdtree setlocal nocursorcolumn
    autocmd FileType vim-plug setlocal nocursorline
    autocmd FileType vim-plug setlocal nocursorcolumn
augroup END
