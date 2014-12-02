" Additional configuration for Tabular

" Continue only if Tabular is loaded
if !exists(':Tabularize')
    finish
endif

AddTabularPipeline! space /\S\zs\s\+/
    \ map(a:lines, "substitute(v:val, '.\\S\\zs\\s\\+', ' ', 'g')")
    \ | tabular#TabularizeStrings(a:lines, ' ', 'l0')

AddTabularPattern textable /&\|\\\\/r1

noremap <leader>tt :Tabularize<space>

noremap <silent> <leader>t<space> :Tabularize space<cr>
noremap <silent> <leader>t=       :Tabularize assignment<cr>
noremap <silent> <leader>t&       :Tabularize textable<cr>
noremap <silent> <leader>t:       :Tabularize /:\zs/l0r1<cr>
