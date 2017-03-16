"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"    -> General
"    -> Pathogen
"    -> Gruvbox
"    -> Ctags & Tagbar
"    -> Upload section to Uplio
"    -> UltiSnips
"    -> Syntastic
"    -> OmniSharp
"    -> Airline
"    -> Racer (rust)
"    -> Extradite (git diff view)
"    -> vim-go
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" => Load pathogen paths
""""""""""""""""""""""""""""""
call pathogen#infect('~/.vim_runtime/plugins')
call pathogen#helptags()


""""""""""""""""""""""""""""""
" => Gruvbox
""""""""""""""""""""""""""""""
colorscheme gruvbox
""let g:gruvbox_termcolors=16 " for very shitty display / screen / term
let g:gruvbox_contrast_dark="dark"
"let g:gruvbox_contrast_light="hard"

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
" => Uplio.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:uplio_key = 'n3g7ui1z28o71ikbthni8k1asgj2614j'

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
"let g:syntastic_check_on_wq = 0
"let g:syntastic_loc_list_height = 5
"let g:syntastic_aggregate_errors = 1
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
"let g:syntastic_disabled_filetypes=['html']
"let g:syntastic_enable_signs=1
"
"let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
"let g:syntastic_go_checkers = ['gobuild', 'govet', 'errcheck']
"let g:syntastic_python_checkers = ['flake8']
"let g:syntastic_python_flake8_exec = 'flake8-python2'
"
" Write this in your vimrc file
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
" You can disable this option too
" if you don't want linters to run on opening a file
"let g:ale_lint_on_enter = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neocomplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'"

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
function! s:my_cr_function()
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
imap <expr><silent> <CR> <SID>my_cr_function()
imap <C-X><CR> <CR><Plug>AlwaysEnd

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-go
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_def_mapping_enabled = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => command-t
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:CommandTWildIgnore=&wildignore . ",*/*vendor"
