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


call plug#end()

if vim_plug_just_installed
	echo "Installing BUndles, please ignore key map error messages"
	:PlugInstall
endif


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
" E opens as well
cnoreabbrev E e

set mouse=n

" clear current search hihlight by //
nmap <silent> // :nohlsearch<CR>
" search for highlighted word with //
vnoremap // y/<C-R>"<CR>

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
nmap <unique> <silent> <Leader>a <Plug>MarkSet
vmap <unique> <silent> <Leader>a <Plug>MarkSet

vnoremap B :!Black -<CR>

set splitbelow
set splitright


" Filetypes
" =========
" Python
autocmd Filetype python setlocal expandtab ts=4 sw=4 sts=4 tw=79
autocmd BufWritePost *.py call Flake8()
let g:flake8_show_in_file=1


" gui
set termguicolors
" prevent the konsole font size problem
set guicursor=

source ~/.nvimrc.local
