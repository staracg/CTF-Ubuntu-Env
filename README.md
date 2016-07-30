# Ubuntu-Env
### Install for CTF on Ubuntu-64bits
 - Vim
 - python-dev
 - strace
 - ltrace
 - nmap
 - Vundle
 - My Configuration
 - powerline
    - http://powerline.readthedocs.org/en/master/index.html
 - z3
    - https://github.com/Z3Prover/z3
 - GDB peda
    - https://github.com/longld/peda
 - pwntools
    - https://github.com/Gallopsled/pwntools
 - ROPgadget
    - https://github.com/JonathanSalwan/ROPgadget
 - qira
    - https://github.com/BinaryAnalysisPlatform/qira
 - Screen
 ![Alt Text](http://i.imgur.com/veZ4o3e.png)

 - Vim screenshot
 ![Alt Text](http://i.imgur.com/ZtFGSLQ.png)

 - Vim Plugin
```
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'airblade/vim-gitgutter'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle 'Townk/vim-autoclose'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-fugitive'
Bundle 'honza/vim-snippets'
Bundle 'garbas/vim-snipmate'
Bundle 'rstacruz/sparkup'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'Valloric/YouCompleteMe'
Plugin 'sheerun/vim-wombat-scheme'
---
Press F1 to open NERDTree
---
```

### Installation

```
 cd ~/
 git clone https://github.com/staracg/Ubuntu-Env.git
 cd Ubuntu-Env/
 ./install.sh
```
### Install YouCompleteMe

```
cd .vim/bundle/YouCompleteMe
sudo python ./install.py --clang-completer
```
