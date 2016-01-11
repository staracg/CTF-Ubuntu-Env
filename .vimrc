" Vundle
" Configuration file for vim
set modelines=0		" CVE-2007-2438
set backspace=2		" more powerful backspacing
set nocompatible  " not compatible with the old-fashion vi mode
filetype off      " required!

" powerline
set rtp+=usr/local/lib/python2.7/dist-packages/powerline/bindings/vim
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup


" http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:"
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'airblade/vim-gitgutter'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle 'Townk/vim-autoclose'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
let NERDTreeMinimalUI=1
let NERDTreeWinSize=25
Bundle 'majutsushi/tagbar'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-fugitive'
Bundle 'honza/vim-snippets'
Bundle 'garbas/vim-snipmate'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'L9'
Bundle 'FuzzyFinder'


"Press F1 to open NERDTree
map <F1> :NERDTreeToggle<CR>
call vundle#end()            " required
filetype plugin indent on    " required
           
"map vim record mode to none
map q <Nop>
scriptencoding utf-8
set encoding=utf-8    
set langmenu=en_US.UTF-8
language message en_US.UTF-8

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

" General
set autoindent               " enable autoindent
set autoread                 " auto read when file is changed from outside "
set expandtab                " use space instead of tab  "
set history=1000             " keep 50 lines of command line history  "
set nu                       "set line number
set ru                       "ruler
syntax on                    "syntax highlighting 
set cursorline               "cursorline highlighting
set scrolloff=5              "the minimal screen line above/below the cursor
set laststatus=2             "狀態列
set clipboard=unnamed        " yank to the system register (*) by default"
set wildmenu
set smarttab
set tabstop=4                "tab=4space
set shiftwidth=4             ">>,<< for 4space"
set bs=2                     "open the backspace"" 
set t_Co=256
set showmatch                " Cursor shows matching ) and }
set showmode                 " Show current mode  "
