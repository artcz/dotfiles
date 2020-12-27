" Vim plug boilerplate
" Do not edit.
let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

call plug#begin("~/.config/nvim/plugged")

" Plugins
Plug 'arielrossanigo/dir-configs-override.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'https://github.com/vim-scripts/Mark--Karkat'
Plug 'https://github.com/endel/vim-github-colorscheme'
Plug 'https://github.com/rafi/awesome-vim-colorschemes'
Plug 'https://github.com/nvie/vim-flake8'
Plug 'vim-scripts/indentpython.vim'
" Plug 'Valloric/YouCompleteMe'
" Plug 'ruanyl/vim-gh-line'
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'
Plug 'tpope/vim-fugitive'
Plug 'rstacruz/sparkup'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pseewald/vim-anyfold'
Plug 'majutsushi/tagbar'

" experimenting with coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Tabularize, markdowns, etc
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'ferrine/md-img-paste.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" This would be nice, but doesnt seem to work well
" Also conflicts with ,a
" Plug 'dominikduda/vim_current_word'

" Journal
Plug 'junegunn/vim-journal'
Plug 'junegunn/goyo.vim'


call plug#end()

if vim_plug_just_installed
	echo "Installing Bundles, please ignore key map error messages"
	:PlugInstall
endif

" :CocInstall coc-python


" for fuzzy finder
set rtp+=~/.fzf


" Bascics
" =======
"

set nu
set hlsearch
set incsearch
colorscheme desert
colorscheme OceanicNext
" 4 spaces not tabs
set expandtab
set sw=4
set ts=4
set sts=4

""" History and backups
" Keep undo history across sessions, by storing in a file.
set undodir=~/.vim/backups
set undofile
set noswapfile


" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·


" Scrolling
" =========
set scrolloff=10         "Start scrolling when we're 10 lines away from margins
set sidescrolloff=10
set sidescroll=1

" Cursor
" ======
set colorcolumn=79
set cursorline
set cursorcolumn

" Maps
" ====

let mapleader=","

map Q gq

" W saves as well
cnoreabbrev W w
" Ctrl-S also saves in normal
nnoremap <silent> <C-s> :w
" E opens as well
cnoreabbrev E e

set mouse=n

" clear current search hihlight by //
nmap <silent> // :nohlsearch<CR>
" search for highlighted word with //
vnoremap // y/<C-R>"<CR>
vnoremap <C-c> :w ! xclip -selection clipboard <CR>

""" Window manipulation
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

"" Splits
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

"" Close quickfix (with flake8 and git grep, etc)
nmap <silent> ,qc :cclose<CR>

"" source vim config from current vile (,vim reload)
nmap <silent> ,vr :so %<CR>

""" fzf bindings
nmap <silent> ,f :Files<CR>
nmap <silent> ,t :Tags<CR>
nmap <silent> ,b :Buffers<CR>
nmap <silent> ,g :Ag<CR>

""" highlights
nmap <silent> <Leader>a <Plug>MarkSet
vmap <silent> <Leader>a <Plug>MarkSet
nmap <space>a <Plug>MarkSet
vmap <space>a <Plug>MarkSet

set splitbelow
set splitright


" Filetypes
" =========

" Json
autocmd Filetype json vnoremap <silent> B :!python3 -m json.tool -<CR>

" Python
autocmd Filetype python setlocal expandtab ts=4 sw=4 sts=4 tw=79
autocmd BufWritePost *.py call Flake8()
autocmd Filetype python vnoremap <silent> i :!isort -<CR>
let g:flake8_show_in_file=1
autocmd Filetype python vnoremap B :!Black -<CR>
autocmd Filetype python nnoremap <space>B :!isort %<CR>:!black -q %<CR>:e %<CR>
autocmd Filetype python nnoremap <space>b ggVG:!isort -<CR>ggVG:!black -q -<CR><C-o>
autocmd Filetype python nnoremap <F2> Iimport pdb; pdb.set_trace()<CR><esc>
autocmd Filetype python inoremap <F2> <esc>Iimport pdb; pdb.set_trace()<CR><esc>i
autocmd Filetype python let @d="Obreakpoint()"   " altenrative approach

" using coc to move around the code -- map just like default ctags
nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> <2-LeftMouse> <Plug>(coc-definition)
nmap <silent> <space>d <Plug>(coc-definition)
""" those two below don't relaly work well
nmap <silent> <2-RightMouse> <C-o>
nmap <silent> <C-LeftMouse> <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
inoremap <silent><expr> <c-space> coc#refresh()

" Map tab for completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Floating window documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" gui
set termguicolors
" prevent the konsole font size problem
set guicursor=


"" experimental
"" managing highlight color for active window
" Background colors for active vs inactive windows
hi InactiveWindow guibg=#17252c
hi ActiveWindow guibg=#0D1B22

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of active/inactive windows
function! Handle_Win_Enter()
  setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
endfunction



"""
" Here goes some specific experimental changes that I pulled from other custom vimrcs I
" used in other projects. I don't even know if they can coexist 
"
"" This is essentially a setup for TODO.txt files
autocmd Filetype text nnoremap <F2> o[ ] (created: <esc>:r!date<CR>kJA)<esc>F]a
autocmd Filetype text nnoremap <C-F2> ^t]rx$xa, completed: <esc>:r!date<CR>kJA)<esc>
" This is exactly the same as above, but ctrl-f2 doesn't work in most terminals (works in nvim-qt tho), so I'm adding additonal mapping for the same feature
autocmd Filetype text nnoremap <space><f2> ^t]rx$xa, completed: <esc>:r!date<CR>kJA)<esc><CR>
autocmd Filetype text nnoremap <space>c ^t]rx$xa, completed: <esc>:r!date<CR>kJA)<esc><CR>

""" unforutnately this doesn't work :sadpanda:
autocmd Filetype text let @t = "o[ ] (created: <esc>:r!date<CR>kJA)<esc>F]a"

autocmd Filetype text set tw=999999 nowrap
autocmd Filetype text syn match celComment "\[x\].*$"
autocmd Filetype text hi def link celComment Comment

" autocmd Filetype text AnyFoldActivate  " better folding for nested lists
" autocmd Filetype text set foldlevel=0
" autocmd Filetype text hi Folded term=underline

" quicksave
" this is game-inspired hack. Press f3 to make a 'quicksave' commit.
" Double the same bind, becase shift-f3 mostly doesn't work in terminals
nnoremap <F3>        : !git add % && git commit -m "quicksave %"
nnoremap <S-F3>      : !git add . && git commit -m "quicksave"
nnoremap <space><F3> : !git add . && git commit -m "quicksave"

nnoremap <F4>        : !git status<CR>
nnoremap <space><F4> : !git push
nnoremap <space><F5> : !git checkout -- .

" Open file manager that will allow pasting in and downloading files.
" %:p:h means 'head of the path of current file' ie. a directory of currently
" open file
nnoremap <F6> :!dolphin %:p:h

" Markdown
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
" Saving the image fiels from clipboard in markdown files.
autocmd FileType markdown nmap <buffer><silent> <space>v :call mdip#MarkdownClipboardImage()<CR>

" Highlight current word plugin
"hi CurrentWord ctermbg=53
"hi CurrentWordTwins ctermbg=237

source ~/.nvimrc.local
