#!/bin/bash
function ask()
{
    while true; do
        read -p "$2" choice
        case $choice in
            [Yy]* )
                declare -g "$1=true"
                break;
                ;;
            [Nn]* )
                declare -g "$1=false"
                break;
                ;;
            *)
                echo "Please enter y or n"
                ;;
        esac
    done
}

ask UPGRADE "Update and upgrade everything? (y/n):"
ask POWERLINE "Install powerline? (y/n):"
ask DOT "Overwrite dot files? (y/n):"
ask CTF "Install CTF environment? (y/n):"
ask PIN "Install Qira's pin_build? (y/n):"

if $UPGRADE; then
    echo "UPGRADE"
    # Update everything
    sudo apt-get update
    sudo apt-get -y upgrade
    sudo apt-get -y dist-upgrade
    sudo apt-get -y install --fix-missing
    sudo apt-get -y autoremove
    sudo apt-get -y autoclean
    sudo pip install pip --upgrade
    
    # Install vim 
    sudo apt-get -y remove vim vim-runtime gvim
    sudo apt-get -y install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git
    cd ~
    git clone https://github.com/vim/vim.git
    cd vim
    ./configure --with-features=huge \
                --enable-multibyte \
                --enable-rubyinterp=yes \
                --enable-pythoninterp=yes \
                --with-python-config-dir=/usr/lib/python2.7/config \
                --enable-python3interp=yes \
                --with-python3-config-dir=/usr/lib/python3.5/config \
                --enable-perlinterp=yes \
                --enable-luainterp=yes \
                --enable-gui=gtk2 \
                --enable-cscope \
                --prefix=/usr/local
    make VIMRUNTIMEDIR=/usr/local/share/vim/vim80
    sudo make install
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
    sudo update-alternatives --set editor /usr/bin/vim
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
    sudo update-alternatives --set vi /usr/bin/vim
fi

if $POWERLINE; then
    echo "POWERLINE"
    # Install pip
    sudo apt-get install -y python-dev
    sudo apt-get install -y python-setuptools
    sudo apt-get install -y easy_install
    sudo easy_install pip
    # Install powerline
    sudo pip install powerline-status

    # Install git complete
    sudo apt-get install -y git bash-completion

    # Install Fonts
    wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
    wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
    mkdir -p ~/.fonts/
    mv PowerlineSymbols.otf ~/.fonts/
    fc-cache -vf ~/.fonts/
    mkdir -p ~/.config/fontconfig/conf.d/
    mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
fi

if $DOT; then
    echo "DOT"
    # Copy dot file
    sudo apt-get install -y build-essential cmake
    sudo apt-get install -y python-dev
    cp .vimrc ~
    cp .bashrc ~
    cp .profile ~
    cp .screenrc ~
    cp .gdbinit ~
    cp .tmux.conf ~
    # Install vim plugin
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
fi

if $CTF; then
    echo "CTF"
    # Install multi architecture
    sudo dpkg --add-architecture i386
    sudo apt-get update
    sudo apt-get install -y gcc-multilib
    
    # Install angr
    cd ~/
    git clone https://github.com/angr/angr.git
    cd angr
    sudo pip install -r requirements.txt
    sudo apt-get install -y python-dev libffi-dev build-essential virtualenvwrapper
    sudo pip install angr --upgrade
    sudo python setup.py install
    
    # Install binwalk
    sudo apt-get install -y binwalk
    
    # Install nmap, strace, ltrace
    sudo apt-get install -y nmap
    sudo apt-get install -y strace
    sudo apt-get install -y ltrace
    
    # Install klee
    curl -sSL https://get.docker.com/ | sudo sh
    sudo docker pull klee/klee
    cd ~/
    wget https://raw.githubusercontent.com/L4ys/LazyKLEE/master/LazyKLEE.py
    chmod +x LazyKLEE.py
    sudo mv LazyKLEE.py /usr/local/bin/LazyKLEE
    
    # Install z3
    cd ~/
    git clone https://github.com/Z3Prover/z3
    cd z3/
    sudo python scripts/mk_make.py --python
    cd build
    sudo make
    sudo make install

    # Install scwuaptx GDB peda and Pwngdb
    sudo apt-get install -y gdb
    cd ~/
    git clone https://github.com/scwuaptx/peda.git ~/.peda
    git clone https://github.com/scwuaptx/Pwngdb.git ~/.pwngdb
    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    cp ~/.peda/.inputrc ~/

    # Install pwntools
    sudo apt-get install -y git python-pip
    cd ~/
    git clone https://github.com/Gallopsled/pwntools.git
    cd pwntools/
    sudo pip install -r requirements.txt
    cd ~/
    git clone https://github.com/aquynh/capstone.git
    cd capstone/
    ./make.sh
    sudo ./make.sh install

    # Install qira
    cd ~/  
    git clone https://github.com/BinaryAnalysisPlatform/qira.git
    cd qira/
    sudo pip install -r requirements.txt
    sudo ./install.sh
    sudo ./fetchlibs.sh
    sudo ./tracers/qemu_build.sh
fi

if $PIN; then
    cd ~/qira/tracers/
    sudo ./pin_build.sh
fi

echo "***************************************"
echo "  Thanks for installing "
echo "  Check out README for more info"
echo "  enjoy it in CTF"
echo "    ~Ayumi"
echo "***************************************"
