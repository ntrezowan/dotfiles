" Basic settings
set nocompatible
set encoding=utf-8
set backspace=indent,eol,start

" Display
" set number
set ruler
set showcmd
set showmatch
set laststatus=2

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Indentation
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

" File handling
filetype plugin indent on
set autoread
set hidden
set noswapfile
set nobackup
set undofile
set undodir=~/.vim/undodir

" Performance
set lazyredraw
set updatetime=300
set timeoutlen=500

" Colors and syntax (Gruvbox)
if $TERM =~? 'alacritty'
    syntax enable
    set background=dark
else
    syntax enable
    set termguicolors
    set background=dark

    let g:gruvbox_contrast_dark = 'soft'
    let g:gruvbox_improved_strings = 1
    let g:gruvbox_improved_warnings = 1
    let g:gruvbox_undercurl = 1
    let g:gruvbox_underline = 1

    colorscheme gruvbox
    hi Normal guibg=NONE ctermbg=NONE
    hi GruvboxRed guifg=#ea6962 ctermfg=red
    hi GruvboxRedBold guifg=#ea6962 ctermfg=red gui=bold cterm=bold
    hi Statement guifg=#ea6962 ctermfg=red
    hi Conditional guifg=#ea6962 ctermfg=red
    hi Repeat guifg=#ea6962 ctermfg=red
    hi Label guifg=#ea6962 ctermfg=red
    hi Exception guifg=#ea6962 ctermfg=red
    hi Keyword guifg=#ea6962 ctermfg=red
endif

" Key mappings
let mapleader = " "
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>h :nohlsearch<CR>
nnoremap Y y$

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Quick escape
inoremap jj <Esc>

" File type specific settings
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType html setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType css setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 expandtab

" Enhanced status line with gruvbox colors
set statusline=%#GruvboxFg1#%f\ 
set statusline+=%#GruvboxRed#%m
set statusline+=%#GruvboxOrange#%r
set statusline+=%#GruvboxYellow#%h
set statusline+=%#GruvboxBlue#%w\ 
set statusline+=%#GruvboxPurple#[%Y]\ 
set statusline+=%#GruvboxAqua#[%{&ff}]\ 
set statusline+=%#GruvboxFg1#%=
set statusline+=%#GruvboxGreen#%l,%c\ 
set statusline+=%#GruvboxBlue#%p%%

" Create undodir if it doesn't exist
if !isdirectory($HOME."/.vim/undodir")
    call mkdir($HOME."/.vim/undodir", "p")
endif

" Better syntax highlighting for common files
autocmd BufRead,BufNewFile *.conf setfiletype conf
autocmd BufRead,BufNewFile *.toml setfiletype toml
autocmd BufRead,BufNewFile *.fish setfiletype fish
