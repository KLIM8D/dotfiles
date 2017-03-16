"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"    -> Python
"    -> Assembly
"    -> Go
"    -> Misc
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python map <buffer> F :set foldmethod=indent<cr>

au FileType python inoremap <buffer> $r return 
au FileType python inoremap <buffer> $i import 
au FileType python inoremap <buffer> $p print 
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class 
au FileType python map <buffer> <leader>2 /def 
au FileType python map <buffer> <leader>C ?class 
au FileType python map <buffer> <leader>D ?def 

""""""""""""""""""""""""""""""""
" => Assembly
""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.s   let asmsyntax='gas'|let filetype_inc='gas'
au BufRead,BufNewFile *.asm let asmsyntax='armasm'|let filetype_inc='armasm'

""""""""""""""""""""""""""""""""
" => Go 
""""""""""""""""""""""""""""""""
autocmd BufWritePost *.go GoBuild

""""""""""""""""""""""""""""""""
" => Misc 
""""""""""""""""""""""""""""""""
"quickfix window height is automatically adjusted to fit its contents (maximum 10 lines). 
aut FileType qf call AdjustWindowHeight(3, 10)
