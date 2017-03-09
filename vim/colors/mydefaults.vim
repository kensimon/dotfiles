hi Comment      term=bold       cterm=NONE      ctermfg=darkgrey     ctermbg=NONE gui=bold      guifg=#7f7f7f guibg=NONE
hi Constant     term=NONE       cterm=NONE      ctermfg=Magenta      ctermbg=NONE gui=NONE      guifg=#FB79FB guibg=NONE
hi String       term=NONE       cterm=NONE      ctermfg=Magenta      ctermbg=NONE gui=NONE      guifg=#FB79FB guibg=NONE
hi Special      term=bold       cterm=NONE      ctermfg=LightRed     ctermbg=NONE gui=bold      guifg=#FFDFDF guibg=NONE
hi Identifier   term=NONE       cterm=bold      ctermfg=Cyan         ctermbg=NONE gui=NONE      guifg=Cyan    guibg=NONE
hi Statement    term=NONE       cterm=NONE      ctermfg=Yellow       ctermbg=NONE gui=NONE      guifg=#FFFD64 guibg=NONE
hi PreProc      term=NONE       cterm=NONE      ctermfg=LightBlue    ctermbg=NONE gui=NONE      guifg=#73DFFD guibg=NONE
hi Type         term=NONE       cterm=NONE      ctermfg=LightGreen   ctermbg=NONE gui=NONE      guifg=#99FABF guibg=NONE
hi Underlined   term=underline  cterm=NONE      ctermfg=LightBlue                 gui=underline guifg=#73DFFD 
hi Ignore       term=NONE       cterm=NONE      ctermfg=black        ctermbg=NONE gui=NONE      guifg=bg      guibg=NONE

hi CursorLine   guifg=NONE    guibg=#343434 gui=NONE   ctermfg=NONE ctermbg=235  cterm=NONE
hi Normal       guifg=#e2e2e5 guibg=#202020 gui=NONE   ctermfg=253  ctermbg=NONE

hi Error      term=reverse cterm=NONE ctermfg=White ctermbg=Red gui=NONE guifg=White guibg=Red
hi Todo       term=standout cterm=NONE ctermfg=Black ctermbg=Yellow gui=NONE guifg=Black guibg=Yellow

" A nice, minimalistic tabline
hi TabLine cterm=bold,NONE      ctermfg=8 ctermbg=NONE
hi TabLineSel cterm=bold ctermfg=0 ctermbg=7
hi TabLineFill cterm=bold ctermbg=NONE

" Stuff that's already a good color in cterm, but I want to fix them for the GUI:
hi NonText        term=bold ctermfg=12 gui=bold guifg=#9292E1

" Common groups that link to default highlighting.
hi link Character      Constant
hi link Number         Constant
hi link Float          Number
hi link Function       Identifier
hi link Conditional    Statement
hi link Repeat         Statement
hi link Label          Statement
hi link Operator       Statement
hi link Keyword        Statement
hi link Exception      Statement
hi link Include        PreProc
hi link Define         PreProc
hi link Macro          PreProc
hi link PreCondit      PreProc
hi link StorageClass   Type
hi link Structure      Type
hi link Typedef        Type
hi link Tag            Special
hi link SpecialChar    Special
hi link Delimiter      Special
hi link SpecialComment Special
hi link Debug          Special
hi link Directory      PreProc
hi link Boolean        Constant

" Stuff that for some reason I have to force highlighting for (hi! instead of
" hi)
hi! link Title          Special
