"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"    -> Pathogen
"    -> Unite
"    -> VIM grep
"    -> Sorround
"    -> Ctags & Tagbar
"    -> Upload section to Uplio
"    -> UltiSnips
"    -> Syntastic
"    -> OmniSharp
"    -> Airline
"    -> Racer (rust)
"    -> Extradite (git diff view)
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" => Load pathogen paths
""""""""""""""""""""""""""""""
call pathogen#infect('~/.vim_runtime/plugins')
call pathogen#helptags()

""""""""""""""""""""""""""""""
" => Unite 
""""""""""""""""""""""""""""""
map <c-b> :Unite buffer<CR>
map <c-f> :Unite -start-insert file<CR>

""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ctags & Tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <silent> <F4> :Tagbar<CR><C-W>l

" Update TagList at every save for theese filetypes
" autocmd BufWritePost *.c :silent! :TlistUpdate
" autocmd BufWritePost *.py :silent! :TlistUpdate

"Build tags libs for the current working directory
" map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Upload selection to Uplio
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Visual Range (Selection)
function! GetVisual()
        let reg_save = getreg('"') 
        let regtype_save = getregtype('"') 
        let cb_save = &clipboard 
        set clipboard& 
        normal! ""gvy 
        let selection = getreg('"') 
        call setreg('"', reg_save, regtype_save) 
        let &clipboard = cb_save 
        return selection 
endfunction 

function! Visual_Uplio()
        let try=GetVisual()
        "" FIXME Refactor this
        let expandy = expand('%:e')
        let buf_fname = expand('%:t')
        let buf_ft = &filetype
        new
        put =try
        """ TODO: Need filetype extension (&filetype)
        if expandy == ""
            execute 'w! /tmp/'.buf_fname.".".buf_ft
        else
            execute 'w! /tmp/'.buf_fname
        endif
        ""write! /tmp/%:t:r (OLD AND WORKED)
        bdelete!
        ""close (bdelete takes care of business)
        "" TODO: Buffer filename for file in tmp
        let sh_out = system('curl -s -F file=@/tmp/'.(expandy=="" ? buf_fname.".".buf_ft : buf_fname).' key=n3g7ui1z28o71ikbthni8k1asgj2614j http://upl.io | xclip -selection clipboard')
        ""echom uplio_out
endfunction
vnoremap UU y:call Visual_Uplio()<Enter>
"" TODO Make Normal_Uplio upload with nnoremap UU
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UltiSnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsSnippetsDir = '~/.vim_runtime/plugins/ultisnips/UltiSnips'

let g:multi_cursor_use_default_mapping = 0
" Default mapping
let g:multi_cursor_next_key = '<C-n>'
let g:multi_cursor_prev_key = '<C-p>'
let g:multi_cursor_skip_key = '<C-x>'
let g:multi_cursor_quit_key = '<Esc>'
let g:UltiSnipsExpandTrigger="<C-CR>"
let g:UltiSnipsJumpForwardTrigger="<C-tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_exec = 'flake8-python2'
let g:syntastic_loc_list_height = 5
let g:syntastic_aggregate_errors = 1

let g:syntastic_go_checkers = ['gobuild', 'govet', 'errcheck']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => OmniSharp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 1

"Showmatch significantly slows down omnicomplete
"when the first match contains parentheses.
set noshowmatch

"don't autoselect first item in omnicomplete, show if only one item (for preview)
"remove preview if you don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview

"Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
"You might also want to look at the echodoc plugin
set splitbelow

" Get Code Issues and syntax errors
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']

augroup omnisharp_commands
    autocmd!

    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

    " automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Automatically add new cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()

    "show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    "The following commands are contextual, based on the current cursor position.

    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr> "finds members in the current buffer
    " cursor can be anywhere on the line containing an issue 
    autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>  
    autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr> "navigate up by method/property/field
    autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr> "navigate down by method/property/field

augroup END

" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=500
" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2

" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable powerline
let g:powerline_loaded = 1

let g:airline_powerline_fonts = 1

" Fix airline/powerline fonts
"if !exists('g:airline_symbols')
"  let g:airline_symbols = {}
"endif
"let g:airline_symbols.space = "\ua0"

let g:airline_theme='luna'

" Enable airline tabline/bufferline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Show buffer positions (numbers)
let g:airline#extensions#tabline#buffer_idx_mode = 1

" Keybindings for airline bufferline (tabline)
nmap <A-1> <Plug>AirlineSelectTab1
nmap <A-2> <Plug>AirlineSelectTab2
nmap <A-3> <Plug>AirlineSelectTab3
nmap <A-4> <Plug>AirlineSelectTab4
nmap <A-5> <Plug>AirlineSelectTab5
nmap <A-6> <Plug>AirlineSelectTab6
nmap <A-7> <Plug>AirlineSelectTab7
nmap <A-8> <Plug>AirlineSelectTab8
nmap <A-9> <Plug>AirlineSelectTab9

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Racer (rust)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set hidden
let g:racer_cmd=$HOME . "/workspace/rust/_racer/target/release/racer"
let $RUST_SRC_PATH=$HOME . "/.src/rust/src/"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Extradite (git diff view)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>d :Extradite!<cr>
