" Vim plugin for Racer
" (by Phil Dawes)
"
" 1. Edit the variables below (or override in .vimrc)
" 2. copy this file into .vim/plugin/
" 3. - now in insert mode do 'C-x C-o' to autocomplete the thing at the cursor
"    - in normal mode do 'gd' to go to definition
"
" (This plugin is best used with the 'hidden' option enabled so that switching buffers doesn't force you to save) 


if !exists('g:racer_cmd')
    let g:racer_cmd = escape(expand('<sfile>:p:h'), '\') . '/../target/release/racer'

    if !(filereadable(g:racer_cmd))
      echohl WarningMsg | echomsg "No racer executable present in " . g:racer_cmd
    endif
endif

if !exists('$RUST_SRC_PATH')
    let s:rust_src_default = 1
    let $RUST_SRC_PATH="/usr/local/src/rust/src"
endif
if !isdirectory($RUST_SRC_PATH)
    if exists('s:rust_src_default')
      echohl WarningMsg | echomsg "No RUST_SRC_PATH environment variable present, nor could default installation be found at: " . $RUST_SRC_PATH
    else
      echohl WarningMsg | echomsg "No directory was found at provided RUST_SRC_PATH: " . $RUST_SRC_PATH
    endif
endif

if !exists('g:racer_experimental_completer')
    let g:racer_experimental_completer = 0
endif

if !exists('g:racer_insert_paren')
    let g:racer_insert_paren = 1
endif

function! RacerGetPrefixCol()
    :w! %.racertmp
    let col = col(".")-1
    let b:racer_col = col
    let fname = expand("%:p")
    let tmpfname=fname.".racertmp"
    let cmd = g:racer_cmd." prefix ".line(".")." ".col." ".tmpfname
    let res = system(cmd)
    let prefixline = split(res, "\\n")[0]
    let startcol = split(prefixline[7:], ",")[0]
    return startcol
endfunction

function! RacerGetExpCompletions()
    let col = b:racer_col      " use the column from the previous RacerGetPrefixCol() call, since vim ammends it afterwards
    let fname = expand("%:p")
    let tmpfname=fname.".racertmp"
    let cmd = g:racer_cmd." complete ".line(".")." ".col." ".tmpfname
    if has('python')
    python << EOF
from subprocess import check_output
import vim

typeMap = { 'Struct' : 's', 'Module' : 'M', 'Function' : 'f',
            'Crate' : 'C', 'Let' : 'v', 'StructField' : 'm',
            'Impl' : 'i', 'Enum' : 'e', 'EnumVariant' : 'E',
            'Type' : 't', 'FnArg' : 'v', 'Trait' : 'T'
            }
lines = [l[6:] for l in check_output(vim.eval('cmd').split()).splitlines() if l.startswith('MATCH')]
candidates = []
for line in lines:
    completions = line.split(',',5)
    kind = typeMap[completions[4]]
    completion = {'kind' : kind, 'word' : completions[0]}
    if kind == 'f': #function
        completion['abbr'] = completions[5].replace('pub ','').replace('fn ','').rstrip('{')
        if int(vim.eval('g:racer_insert_paren')):
            completion['word'] += '('
        completion['info'] = completions[5]
    elif kind == 's' : #struct
        completion['abbr'] = completions[5].replace('pub ','').replace('struct ','').rstrip('{')
    candidates.append(completion)

vim.command("return %s" % candidates)

EOF
    else
        echoerr("Error, experimental racer completion requires vim compiled
                    \ with python 2.")
    endif
    call delete(tmpfname)
endfunction

function! RacerGetCompletions()
    let col = b:racer_col      " use the column from the previous RacerGetPrefixCol() call, since vim ammends it afterwards
    let fname = expand("%:p")
    let tmpfname=fname.".racertmp"
    let cmd = g:racer_cmd." complete ".line(".")." ".col." ".tmpfname
    let res = system(cmd)
    let lines = split(res, "\\n")
    let out = []
    for line in lines
       if line =~ "^MATCH"
           let completion = split(line[6:], ",")[0]
           let out = add(out, completion)
       endif
    endfor
    call delete(tmpfname)
    return out
endfunction

function! RacerGoToDefinition()
    :w! %.racertmp
    let col = col(".")-1
    let b:racer_col = col
    let fname = expand("%:p")
    let tmpfname=fname.".racertmp"
    let cmd = g:racer_cmd." find-definition ".line(".")." ".col." ".tmpfname
    let res = system(cmd)
    let lines = split(res, "\\n")
    for line in lines
        if line =~ "^MATCH"
             let linenum = split(line[6:], ",")[1]
             let colnum = split(line[6:], ",")[2]
             let fname = split(line[6:], ",")[3]
             if fname =~ ".racertmp$"
                 let fname = fname[:-10]
             endif
             call RacerJumpToLocation(fname, linenum, colnum)
             break
        endif
    endfor
    call delete(tmpfname)
endfunction

function! RacerJumpToLocation(filename, linenum, colnum)
    if(a:filename != '')
        if a:filename != bufname('%')
            exec 'e ' . fnameescape(a:filename)
        endif
        normal! m`
        call cursor(a:linenum, a:colnum+1)
    endif
endfunction

function! RacerComplete(findstart, base)
    if a:findstart
        return RacerGetPrefixCol()
    else
        if g:racer_experimental_completer == 1
            return RacerGetExpCompletions()
        else
            return RacerGetCompletions()
        endif
    endif
endfunction

autocmd FileType rust setlocal omnifunc=RacerComplete
autocmd FileType rust nnoremap gd :call RacerGoToDefinition()<cr>

