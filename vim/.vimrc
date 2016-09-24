" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" TODO: this may not be in the correct place. It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif

" =============== Pathogen Initialization ===============
" This loads all the plugins in ~/.vim/bundle
" Use tpope's pathogen plugin to manage all other plugins

  runtime bundle/tpope-vim-pathogen/autoload/pathogen.vim
  call pathogen#infect()
  call pathogen#helptags()

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" ================ Search Settings  =================

set incsearch        "Find the next match as we type the search
set hlsearch         "Hilight searches by default
set viminfo='100,f1  "Save up to 100 marks, enable capital marks

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

set undodir=~/.vim/backups
set undofile

" ================ Indentation ======================

set noautoindent
" this will cause weird stuff with python, like moving new comments to first
" column, and blocking '<<' and '>>' on comments. Conclusion: don't use
" smartindent
"set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set wrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

"

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

for f in split(glob('~/.vim/plugin/settings/*.vim'), '\n')
  exe 'source' f
endfor


" Moje poprawki
let g:ctrlp_by_filename = 0

set colorcolumn=79
set cursorline
set nocursorcolumn
map <F11> :set hls!<Bar>set hls?<CR>
map <F10> :set paste!<Bar>set paste?<CR>
map <F4>  :NERDTreeToggle<CR>:TagbarToggle<CR>
map <F9>  :set wrap!<Bar>set wrap?<CR>
nnoremap <C-f> :CtrlPTag<cr>
set textwidth=79

set ttyfast
au BufNewFile,BufRead *.dhtml,*.html.django,*.d.html setf htmldjango
autocmd FileType python set ft=python.django
autocmd Filetype python setlocal expandtab ts=4 sw=4 sts=4 tw=79
autocmd Filetype html setlocal expandtab tw=31337 ts=2 sw=2 sts=2
autocmd Filetype htmldjango setlocal expandtab tw=31337
autocmd Filetype yaml setlocal expandtab ts=2 sw=2 sts=2 tw=120
autocmd Filetype yml setlocal expandtab ts=2 sw=2 sts=2 tw=120
" autocmd BufWritePre *.py Isort
autocmd BufWritePre *.py PyCoverageHighlight

set ssop-=options
set ssop-=folds
set noeb
set novb

inoremap jj <Esc>
" default in gentoo, not present in ubuntu
map Q gq

" for nerd commenter
let g:NERDSpaceDelims = 1

" W saves as well
cnoreabbrev W w
" E opens as well
cnoreabbrev E e

set mouse=a

" quicksave
" this is game-inspired hack. Press f6 to make a 'quicksave' commit.
nnoremap <F6> :!git add . && git commit -a -m "quisksave"
" and quickload
nnoremap <F7> :!git checkout -- .

" search for highlighted text with //
vnoremap // y/<C-R>"<CR>
