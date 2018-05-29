" Include the system settings
" :if filereadable( "/etc/vimrc" )
"    source /etc/vimrc
" :endif
"
execute pathogen#infect()
syntax on
filetype plugin indent on

let idnt = 3

" General Config
" =============================================================================
set mouse=a
set encoding=utf-8
set t_Co=256                                  " set 256-color format
set background=light                          " set background color to theme
set number                                    " set line number
set ruler                                     " show row and column position
set tabstop=4                                 " tab length
set shiftwidth=4                              " set number of spaces for autoindent
set expandtab                                 " convert tabs into spaces
set laststatus=2                              " shows status line
set statusline=%F\ %=L:\ %l\,\ C:\ %c         " status line format
set hlsearch                                  " enable search highlighting
set foldnestmax=2
set foldmethod=syntax
set foldtext=FoldText()
set fillchars=                                " remove '-'s in fold
let loaded_matchparen = 1                     " disable parentheses highlighting

autocmd Filetype python set foldmethod=indent " required for .py to fold properly
autocmd Filetype perl   set foldmethod=indent " required for .pl to fold properly
autocmd Filetype zsh    set foldmethod=indent
autocmd Filetype make   set noexpandtab

" Color Configurations
" =============================================================================
highlight Search    ctermfg=black
highlight Directory ctermfg=blue
highlight Comment   ctermfg=33
highlight String    ctermfg=196
highlight Character ctermfg=196
highlight Number    ctermfg=196
highlight Boolean   ctermfg=196
highlight Float     ctermfg=196
highlight Constant  ctermfg=196
highlight Statement ctermfg=brown
highlight LineNr    ctermfg=brown
highlight Type      ctermfg=71
highlight PreProc   ctermfg=141
highlight Special   ctermfg=141
highlight Folded    gui=bold guifg=cyan ctermfg=180 guibg=NONE ctermbg=NONE

let g:indexed_search_colors = 0

" Key Mappings
" =============================================================================
nnoremap <space> za
vnoremap <space> zf
nnoremap <s-w> <c-w>
nnoremap <s-e> <c-e>
nnoremap <s-y> <c-y>
nnoremap <s-u> <c-u>
nnoremap <s-d> <c-d>
nnoremap <s-f> <c-f>
nnoremap <s-b> <c-b>

" Helper Functions
" =============================================================================
function! s:Strip(string)
    return substitute(a:string, 
    \ '^[[:space:][:return:][:cntrl:]]\+\|[[:space:][:return:][:cntrl:]]\+$', '', '')
endfunction

" Extract the first line of a multi-line comment to use as the fold snippet
function! FoldText()
    let l:snippet = getline(v:foldstart)
    if len(s:Strip(l:snippet)) == 3
        let l:snippet = strpart(l:snippet, 1) . s:Strip(getline(v:foldstart + 1))
    endif
    return l:snippet . ' ...'
endfunction

au BufNewFile,BufRead *.cpp set syntax=cpp11

" Helper Functions
" =============================================================================
map <C-K> :pyf ~/clang-format.py<cr>
imap <C-K><c-o> :pyf ~/clang-format.py<cr>

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
