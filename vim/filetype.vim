if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    " Oz
    au BufNewFile,BufRead *.oz,*.org,*.ozg setf oz
    " oh-my-zsh theme
    au BufNewFile,BufRead *.zsh-theme setf zsh
augroup END
