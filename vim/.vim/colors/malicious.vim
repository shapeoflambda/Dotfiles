" Name:         Malicious
" Description:  A malicious colorscheme for vim
" Author:       Harish Chandran <shapeoflmabda@gmail.com>
" Maintainer:   Harish Chandran <shapeoflmabda@gmail.com>
" License:      Public domain
" Last Updated: Sat May 16 19:57:02 2020

" Generated by Colortemplate v2.0.0

set background=dark

hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'malicious'

let s:t_Co = exists('&t_Co') && !empty(&t_Co) && &t_Co > 1 ? &t_Co : 2
let s:italics = (&t_ZH != '' && &t_ZH != '[7m') || has('gui_running')

hi! link QuickFixLine Search
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link Boolean Constant
hi! link Character Constant
hi! link Conditional Statement
hi! link Define PreProc
hi! link Debug Special
hi! link Delimiter Special
hi! link Exception Statement
hi! link Float Constant
hi! link Function Identifier
hi! link Include PreProc
hi! link Keyword Statement
hi! link Label Statement
hi! link Macro PreProc
hi! link Number Constant
hi! link Operator Statement
hi! link PreCondit PreProc
hi! link Repeat Statement
hi! link SpecialChar Special
hi! link SpecialComment Special
hi! link StorageClass Type
hi! link String Constant
hi! link Structure Type
hi! link Tag Special
hi! link Typedef Type
hi! link lCursor Cursor

if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#1f1a21', '#b74634', '#68c467', '#b74634',
        \ '#3377f3', '#000000', '#000000', '#e2e0e3', '#000000', '#000000',
        \ '#000000', '#000000', '#000000', '#000000', '#000000', '#e0e0ed']
  if get(g:, 'dark_transp_bg', 0) && !has('gui_running')
    hi Normal guifg=#e2e0e3 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Terminal guifg=#e2e0e3 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  else
    hi Normal guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
    hi Terminal guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  endif
  hi ColorColumn guifg=fg guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi Conceal guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Cursor guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi CursorColumn guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi CursorLine guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi CursorLineNr guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi DiffAdd guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=reverse cterm=reverse
  hi DiffChange guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=reverse cterm=reverse
  hi DiffDelete guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=reverse cterm=reverse
  hi DiffText guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=bold,reverse cterm=bold,reverse
  hi Directory guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi EndOfBuffer guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi ErrorMsg guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=reverse cterm=reverse
  hi FoldColumn guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi Folded guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=italic cterm=italic
  hi IncSearch guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=standout cterm=standout
  hi LineNr guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi MatchParen guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi ModeMsg guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi MoreMsg guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi NonText guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi Pmenu guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi PmenuSbar guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi PmenuSel guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi PmenuThumb guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi Question guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi Search guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi SignColumn guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi SpecialKey guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi SpellBad guifg=#e2e0e3 guibg=#1f1a21 guisp=#b74634 gui=NONE cterm=NONE
  hi SpellCap guifg=#e2e0e3 guibg=#1f1a21 guisp=#3377f3 gui=NONE cterm=NONE
  hi SpellLocal guifg=#e2e0e3 guibg=#1f1a21 guisp=#000000 gui=NONE cterm=NONE
  hi SpellRare guifg=#e2e0e3 guibg=#1f1a21 guisp=#000000 gui=reverse cterm=reverse
  hi StatusLine guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi StatusLineNC guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi TabLine guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi TabLineFill guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi TabLineSel guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi Title guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi VertSplit guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi Visual guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi VisualNOS guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi WarningMsg guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi WildMenu guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi Comment guifg=#e2e0e3 guibg=NONE guisp=NONE gui=italic cterm=italic
  hi Constant guifg=#e2e0e3 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Error guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=reverse cterm=reverse
  hi Identifier guifg=#e2e0e3 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Ignore guifg=#e2e0e3 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi PreProc guifg=#e2e0e3 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Special guifg=#e2e0e3 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Statement guifg=#e2e0e3 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Todo guifg=#e2e0e3 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Type guifg=#e2e0e3 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Underlined guifg=#e2e0e3 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi CursorIM guifg=NONE guibg=fg guisp=NONE gui=NONE cterm=NONE
  hi ToolbarLine guifg=NONE guibg=#1f1a21 guisp=NONE gui=NONE cterm=NONE
  hi ToolbarButton guifg=#e2e0e3 guibg=#1f1a21 guisp=NONE gui=bold cterm=bold
  if !s:italics
    hi Folded gui=NONE cterm=NONE
    hi Comment gui=NONE cterm=NONE
  endif
  unlet s:t_Co s:italics
  finish
endif

if s:t_Co >= 256
  if get(g:, 'dark_transp_bg', 0)
    hi Normal ctermfg=254 ctermbg=NONE cterm=NONE
    hi Terminal ctermfg=254 ctermbg=NONE cterm=NONE
  else
    hi Normal ctermfg=254 ctermbg=234 cterm=NONE
    if !has('patch-8.0.0616') " Fix for Vim bug
      set background=dark
    endif
    hi Terminal ctermfg=254 ctermbg=234 cterm=NONE
  endif
  hi ColorColumn ctermfg=fg ctermbg=234 cterm=NONE
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Cursor ctermfg=254 ctermbg=234 cterm=NONE
  hi CursorColumn ctermfg=254 ctermbg=234 cterm=NONE
  hi CursorLine ctermfg=254 ctermbg=234 cterm=NONE
  hi CursorLineNr ctermfg=254 ctermbg=234 cterm=NONE
  hi DiffAdd ctermfg=254 ctermbg=234 cterm=reverse
  hi DiffChange ctermfg=254 ctermbg=234 cterm=reverse
  hi DiffDelete ctermfg=254 ctermbg=234 cterm=reverse
  hi DiffText ctermfg=254 ctermbg=234 cterm=bold,reverse
  hi Directory ctermfg=254 ctermbg=234 cterm=NONE
  hi EndOfBuffer ctermfg=254 ctermbg=234 cterm=NONE
  hi ErrorMsg ctermfg=254 ctermbg=234 cterm=reverse
  hi FoldColumn ctermfg=254 ctermbg=234 cterm=NONE
  hi Folded ctermfg=254 ctermbg=234 cterm=italic
  hi IncSearch ctermfg=254 ctermbg=234 cterm=reverse
  hi LineNr ctermfg=254 ctermbg=234 cterm=NONE
  hi MatchParen ctermfg=254 ctermbg=234 cterm=NONE
  hi ModeMsg ctermfg=254 ctermbg=234 cterm=NONE
  hi MoreMsg ctermfg=254 ctermbg=234 cterm=NONE
  hi NonText ctermfg=254 ctermbg=234 cterm=NONE
  hi Pmenu ctermfg=254 ctermbg=234 cterm=NONE
  hi PmenuSbar ctermfg=254 ctermbg=234 cterm=NONE
  hi PmenuSel ctermfg=254 ctermbg=234 cterm=NONE
  hi PmenuThumb ctermfg=254 ctermbg=234 cterm=NONE
  hi Question ctermfg=254 ctermbg=234 cterm=NONE
  hi Search ctermfg=254 ctermbg=234 cterm=NONE
  hi SignColumn ctermfg=254 ctermbg=234 cterm=NONE
  hi SpecialKey ctermfg=254 ctermbg=234 cterm=NONE
  hi SpellBad ctermfg=254 ctermbg=234 cterm=NONE
  hi SpellCap ctermfg=254 ctermbg=234 cterm=NONE
  hi SpellLocal ctermfg=254 ctermbg=234 cterm=NONE
  hi SpellRare ctermfg=254 ctermbg=234 cterm=reverse
  hi StatusLine ctermfg=254 ctermbg=234 cterm=NONE
  hi StatusLineNC ctermfg=254 ctermbg=234 cterm=NONE
  hi TabLine ctermfg=254 ctermbg=234 cterm=NONE
  hi TabLineFill ctermfg=254 ctermbg=234 cterm=NONE
  hi TabLineSel ctermfg=254 ctermbg=234 cterm=NONE
  hi Title ctermfg=254 ctermbg=234 cterm=NONE
  hi VertSplit ctermfg=254 ctermbg=234 cterm=NONE
  hi Visual ctermfg=254 ctermbg=234 cterm=NONE
  hi VisualNOS ctermfg=254 ctermbg=234 cterm=NONE
  hi WarningMsg ctermfg=254 ctermbg=234 cterm=NONE
  hi WildMenu ctermfg=254 ctermbg=234 cterm=NONE
  hi Comment ctermfg=254 ctermbg=NONE cterm=italic
  hi Constant ctermfg=254 ctermbg=NONE cterm=NONE
  hi Error ctermfg=254 ctermbg=234 cterm=reverse
  hi Identifier ctermfg=254 ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=254 ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=254 ctermbg=NONE cterm=NONE
  hi Special ctermfg=254 ctermbg=NONE cterm=NONE
  hi Statement ctermfg=254 ctermbg=NONE cterm=NONE
  hi Todo ctermfg=254 ctermbg=NONE cterm=NONE
  hi Type ctermfg=254 ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=254 ctermbg=NONE cterm=NONE
  hi CursorIM ctermfg=NONE ctermbg=fg cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=234 cterm=NONE
  hi ToolbarButton ctermfg=254 ctermbg=234 cterm=bold
  if !s:italics
    hi Folded cterm=NONE
    hi Comment cterm=NONE
  endif
  unlet s:t_Co s:italics
  finish
endif

if s:t_Co >= 8
  if get(g:, 'dark_transp_bg', 0)
    hi Normal ctermfg=LightGrey ctermbg=NONE cterm=NONE
    hi Terminal ctermfg=LightGrey ctermbg=NONE cterm=NONE
  else
    hi Normal ctermfg=LightGrey ctermbg=Black cterm=NONE
    hi Terminal ctermfg=LightGrey ctermbg=Black cterm=NONE
  endif
  hi ColorColumn ctermfg=fg ctermbg=Black cterm=NONE
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Cursor ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi CursorColumn ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi CursorLine ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi CursorLineNr ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi DiffAdd ctermfg=LightGrey ctermbg=Black cterm=reverse
  hi DiffChange ctermfg=LightGrey ctermbg=Black cterm=reverse
  hi DiffDelete ctermfg=LightGrey ctermbg=Black cterm=reverse
  hi DiffText ctermfg=LightGrey ctermbg=Black cterm=bold,reverse
  hi Directory ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi EndOfBuffer ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi ErrorMsg ctermfg=LightGrey ctermbg=Black cterm=reverse
  hi FoldColumn ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi Folded ctermfg=LightGrey ctermbg=Black cterm=italic
  hi IncSearch ctermfg=LightGrey ctermbg=Black cterm=reverse
  hi LineNr ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi MatchParen ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi ModeMsg ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi MoreMsg ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi NonText ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi Pmenu ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi PmenuSbar ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi PmenuSel ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi PmenuThumb ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi Question ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi Search ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi SignColumn ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi SpecialKey ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi SpellBad ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi SpellCap ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi SpellLocal ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi SpellRare ctermfg=LightGrey ctermbg=Black cterm=reverse
  hi StatusLine ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi StatusLineNC ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi TabLine ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi TabLineFill ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi TabLineSel ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi Title ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi VertSplit ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi Visual ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi VisualNOS ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi WarningMsg ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi WildMenu ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi Comment ctermfg=LightGrey ctermbg=NONE cterm=italic
  hi Constant ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi Error ctermfg=LightGrey ctermbg=Black cterm=reverse
  hi Identifier ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi Special ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi Statement ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi Todo ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi Type ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi CursorIM ctermfg=NONE ctermbg=fg cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=Black cterm=NONE
  hi ToolbarButton ctermfg=LightGrey ctermbg=Black cterm=bold
  if !s:italics
    hi Folded cterm=NONE
    hi Comment cterm=NONE
  endif
  unlet s:t_Co s:italics
  finish
endif

if s:t_Co >= 2
  hi Normal term=NONE
  hi ColorColumn term=reverse
  hi Conceal term=NONE
  hi Cursor term=NONE
  hi CursorColumn term=reverse
  hi CursorLine term=underline
  hi CursorLineNr term=bold,italic,reverse,underline
  hi DiffAdd term=reverse,underline
  hi DiffChange term=reverse,underline
  hi DiffDelete term=reverse,underline
  hi DiffText term=bold,reverse,underline
  hi Directory term=NONE
  hi EndOfBuffer term=NONE
  hi ErrorMsg term=bold,italic,reverse
  hi FoldColumn term=reverse
  hi Folded term=italic,reverse,underline
  hi IncSearch term=bold,italic,reverse
  hi LineNr term=reverse
  hi MatchParen term=bold,underline
  hi ModeMsg term=NONE
  hi MoreMsg term=NONE
  hi NonText term=NONE
  hi Pmenu term=reverse
  hi PmenuSbar term=NONE
  hi PmenuSel term=NONE
  hi PmenuThumb term=NONE
  hi Question term=standout
  hi Search term=italic,underline
  hi SignColumn term=reverse
  hi SpecialKey term=bold
  hi SpellBad term=italic,underline
  hi SpellCap term=italic,underline
  hi SpellLocal term=italic,underline
  hi SpellRare term=italic,underline
  hi StatusLine term=bold,reverse
  hi StatusLineNC term=reverse
  hi TabLine term=italic,reverse,underline
  hi TabLineFill term=reverse,underline
  hi TabLineSel term=bold
  hi Title term=bold
  hi VertSplit term=reverse
  hi Visual term=reverse
  hi VisualNOS term=NONE
  hi WarningMsg term=standout
  hi WildMenu term=bold
  hi Comment term=italic
  hi Constant term=bold,italic
  hi Error term=reverse
  hi Identifier term=italic
  hi Ignore term=NONE
  hi PreProc term=italic
  hi Special term=bold,italic
  hi Statement term=bold
  hi Todo term=bold,underline
  hi Type term=bold
  hi Underlined term=underline
  hi CursorIM term=NONE
  hi ToolbarLine term=reverse
  hi ToolbarButton term=bold,reverse
  if !s:italics
    hi CursorLineNr term=bold,reverse,underline
    hi ErrorMsg term=bold,reverse
    hi Folded term=reverse,underline
    hi IncSearch term=bold,reverse
    hi Search term=underline
    hi SpellBad term=underline
    hi SpellCap term=underline
    hi SpellLocal term=underline
    hi SpellRare term=underline
    hi TabLine term=reverse,underline
    hi Comment term=NONE
    hi Constant term=bold
    hi Identifier term=NONE
    hi PreProc term=NONE
    hi Special term=bold
  endif
  unlet s:t_Co s:italics
  finish
endif

" Background: dark
" Color:  bg0            #1f1a21  ~        Black
" Color:  red            #b74634  ~        DarkRed
" Color:  green          #68c467  ~        DarkGreen
" Color:  yellow         #b74634  ~        DarkYellow
" Color:  blue           #3377f3  ~        DarkBlue
" Color:  magenta        #000000  ~        DarkMagenta
" Color:  cyan           #000000  ~        DarkCyan
" Color:  white          #e2e0e3  ~        LightGrey
" Color:  brightblack    #000000  ~        DarkGrey
" Color:  brightred      #000000  ~        LightRed
" Color:  brightgreen    #000000  ~        LightGreen
" Color:  brightyellow   #000000  ~        LightYellow
" Color:  brightblue     #000000  ~        LightBlue
" Color:  brightmagenta  #000000  ~        LightMagenta
" Color:  brightcyan     #000000  ~        LightCyan
" Color: brightwhite   #e0e0ed                  231        White
" Term colors: bg0 red green yellow blue magenta cyan white
" Term colors: brightblack brightred brightgreen brightyellow
" Term colors: brightblue brightmagenta brightcyan brightwhite
" vim: et ts=2 sw=2