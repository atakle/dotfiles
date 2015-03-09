" These settings only make sense if NERDTree is loaded
if !exists(':NERDTree')
    finish
endif

" Quit if NERDTree is the last remaining window.
augroup auNERD
    autocmd!
    autocmd bufenter *
        \ if (winnr("$") == 1 &&
        \     exists("b:NERDTreeType") &&
        \     b:NERDTreeType == "primary")
        \ | q | endif
augroup END

" Toggle NERDTree display.
nnoremap <silent> <leader>tr :NERDTreeToggle<CR>
