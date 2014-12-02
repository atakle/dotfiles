" These settings only make sense if NERDTree is loaded
if !exists(':NERDTree')
    finish
endif

nnoremap <silent> <leader>tr :NERDTreeToggle<CR>
