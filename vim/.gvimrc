set cursorcolumn
set guifont=Menlo\ for\ Powerline\ 10
set guioptions-=T
set guioptions-=m
set mouse=a
colorscheme asmdev

map <silent> <F11>
\    :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>
