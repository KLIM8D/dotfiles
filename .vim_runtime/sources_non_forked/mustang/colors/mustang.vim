" Maintainer:	Henrique C. Alves (hcarvalhoalves@gmail.com)
" Version:      1.0
" Last Change:	September 25 2008

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "mustang"

" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine   guifg=NONE    guibg=#2d2d2d guisp=#2d2d2d gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
  hi CursorColumn guifg=NONE    guibg=#2d2d2d guisp=#2d2d2d gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
  hi ColorColumn  guifg=NONE    guibg=#1e1e1e guisp=#1e1e1e gui=NONE ctermfg=NONE ctermbg=234 cterm=NONE
  hi MatchParen   guifg=#d0ffc0 guibg=#2f2f2f guisp=#2f2f2f gui=bold ctermfg=193  ctermbg=236 cterm=bold
  hi PMenu        guifg=#ffffff guibg=#444444 guisp=#444444 gui=NONE ctermfg=15   ctermbg=238 cterm=NONE
  hi PMenuSel     guifg=#000000 guibg=#b1d631 guisp=#b1d631 gui=NONE ctermfg=NONE ctermbg=149 cterm=NONE
endif

" General colors
hi Cursor         guifg=NONE    guibg=#626262 guisp=#626262 gui=NONE ctermfg=NONE ctermbg=241 cterm=NONE
hi Normal         guifg=#e2e2e5 guibg=#202020 guisp=#202020 gui=NONE ctermfg=254  ctermbg=234 cterm=NONE
hi NonText        guifg=#808080 guibg=#303030 guisp=#303030 gui=NONE ctermfg=237  ctermbg=236 cterm=NONE
hi LineNr         guifg=#808080 guibg=#292929 guisp=#292929 gui=NONE ctermfg=237  ctermbg=235 cterm=NONE
hi SignColumn     guifg=#808080 guibg=#292929 guisp=#292929 gui=NONE ctermfg=237  ctermbg=235 cterm=NONE
hi StatusLine     guifg=#d3d3d5 guibg=#444444 guisp=#444444 gui=italic ctermfg=188 ctermbg=238 cterm=NONE
hi StatusLineNC   guifg=#939395 guibg=#444444 guisp=#444444 gui=NONE ctermfg=246  ctermbg=238 cterm=NONE
hi VertSplit      guifg=#444444 guibg=#444444 guisp=#444444 gui=NONE ctermfg=238  ctermbg=238 cterm=NONE
hi FoldColumn     guifg=NONE    guibg=#292929 guisp=#292929 gui=NONE ctermfg=NONE ctermbg=235 cterm=NONE
hi Folded         guifg=#a0a8b0 guibg=#384048 guisp=#384048 gui=NONE ctermfg=103  ctermbg=238 cterm=NONE
hi Title          guifg=#f6f3e8 guibg=NONE    guisp=NONE    gui=bold ctermfg=230  ctermbg=NONE cterm=bold
hi Visual         guifg=#faf4c6 guibg=#3c414c guisp=#3c414c gui=NONE ctermfg=230  ctermbg=239 cterm=NONE
hi SpecialKey     guifg=#808080 guibg=#343434 guisp=#343434 gui=NONE ctermfg=237  ctermbg=236 cterm=NONE
hi TabLineFill    guifg=NONE    guibg=#424242 guisp=#424242 gui=NONE ctermfg=NONE ctermbg=238 cterm=NONE
hi TabLine        guifg=NONE    guibg=#424242 guisp=#424242 gui=NONE ctermfg=NONE ctermbg=238 cterm=NONE

" Syntax highlighting
hi Comment        guifg=#808080 guibg=NONE guisp=NONE gui=italic ctermfg=237 ctermbg=NONE cterm=NONE
hi Todo           guifg=#8f8f8f guibg=NONE guisp=NONE gui=italic ctermfg=245 ctermbg=NONE cterm=NONE
hi Boolean        guifg=#b1d631 guibg=NONE guisp=NONE gui=NONE ctermfg=149 ctermbg=NONE cterm=NONE
hi String         guifg=#b1d631 guibg=NONE guisp=NONE gui=italic ctermfg=149 ctermbg=NONE cterm=NONE
hi Identifier     guifg=#b1d631 guibg=NONE guisp=NONE gui=NONE ctermfg=149 ctermbg=NONE cterm=NONE
hi Function       guifg=#ffffff guibg=NONE guisp=NONE gui=bold ctermfg=15  ctermbg=NONE cterm=bold
hi Type           guifg=#7e8aa2 guibg=NONE guisp=NONE gui=NONE ctermfg=103 ctermbg=NONE cterm=NONE
hi Statement      guifg=#7e8aa2 guibg=NONE guisp=NONE gui=NONE ctermfg=103 ctermbg=NONE cterm=NONE
hi Keyword        guifg=#ff9800 guibg=NONE guisp=NONE gui=NONE ctermfg=208 ctermbg=NONE cterm=NONE
hi Constant       guifg=#ff9800 guibg=NONE guisp=NONE gui=NONE ctermfg=208 ctermbg=NONE cterm=NONE
hi Number         guifg=#ff9800 guibg=NONE guisp=NONE gui=NONE ctermfg=208 ctermbg=NONE cterm=NONE
hi Special        guifg=#ff9800 guibg=NONE guisp=NONE gui=NONE ctermfg=208 ctermbg=NONE cterm=NONE
hi PreProc        guifg=#faf4c6 guibg=NONE guisp=NONE gui=NONE ctermfg=230 ctermbg=NONE cterm=NONE

" Git diff
hi Debug          guifg=#BCA3A3 guibg=NONE    guisp=NONE    gui=bold ctermfg=138 ctermbg=NONE cterm=bold
hi Define         guifg=#66D9EF guibg=NONE    guisp=NONE    gui=NONE ctermfg=81  ctermbg=NONE cterm=NONE
hi Delimiter      guifg=#8F8F8F guibg=NONE    guisp=NONE    gui=NONE ctermfg=245 ctermbg=NONE cterm=NONE
hi DiffAdd        guifg=NONE    guibg=#13354A guisp=#13354A gui=NONE ctermfg=NONE ctermbg=23 cterm=NONE
hi DiffChange     guifg=#89807D guibg=#4C4745 guisp=#4C4745 gui=NONE ctermfg=245 ctermbg=239 cterm=NONE
hi DiffDelete     guifg=#960050 guibg=#1E0010 guisp=#1E0010 gui=NONE ctermfg=89  ctermbg=53 cterm=NONE
hi DiffText       guifg=NONE    guibg=#4C4745 guisp=#4C4745 gui=bold,italic ctermfg=NONE ctermbg=239 cterm=bold

" Code-specific colors
hi pythonOperator guifg=#7e8aa2 gui=none ctermfg=103

" Different color past 80 columns
execute "set colorcolumn=" . join(range(81,335), ',')
