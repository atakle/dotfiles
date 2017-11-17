" Custom settings for vim-surround.

" Insert block comments around a target with 'c'.
augroup surroundComment
    " TODO: Read the comment characters from &comments instead of hard-coding
    "       them.
    autocmd!
    autocmd FileType c       let b:surround_99 = "/* \r */"
    autocmd FileType cpp     let b:surround_99 = "/* \r */"
    autocmd FileType haskell let b:surround_99 = "{- \r -}"
    autocmd FileType html    let b:surround_99 = "<!- \r ->"
augroup END
