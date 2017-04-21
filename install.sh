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

if $UPGRADE; then
    echo "UPGRADE"
    # Update everything
    sudo apt-get update
    sudo apt-get -y upgrade
    sudo apt-get -y dist-upgrade
    sudo apt-get -y autoremove
    
    # Install vim from source
    sudo apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git
    sudo apt-get remove -y vim vim-runtime
    cd ~/
    git clone https://github.com/vim/vim.git
    cd ~/vim
    ./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --enable-python3interp \
            --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr \
    make VIMRUNTIMEDIR=/usr/share/vim/vim80
    sudo make install
    sudo apt-get install -y vim-runtime
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
    sudo apt-get install -y vim
    sudo apt-get install -y build-essential cmake
    sudo apt-get install -y python-dev
    cp ./.vimrc ~
    cp ./.bashrc ~
    cp ./.bash_profile ~
    cp ./.screenrc ~
    cp ./.gdbinit ~
    cp ./.tmux.conf ~
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
    sudo apt-get install -y python-dev libffi-dev build-essential virtualenvwrapper
    sudo pip install angr --upgrade
    
    # Install binwalk
    sudo apt-get install binwalk
    
    # Install nmap, strace, ltrace
    sudo apt-get install -y nmap
    sudo apt-get install -y strace
    sudo apt-get install -y ltrace

    # Install z3
    cd ~/
    git clone https://github.com/Z3Prover/z3
    cd z3/
    sudo python scripts/mk_make.py --python
    cd build
    sudo make
    sudo make install

    # Install scwuaptx GDB peda and Pwngdb
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
    wget -qO- https://github.com/BinaryAnalysisPlatform/qira/archive/v1.2.tar.gz | tar zx && mv qira* qira
    cd qira/
    sudo pip install -r requirements.txt
    sudo ./install.sh
    sudo ./fetchlibs.sh
    sudo ./tracers/pin_build.sh
    sudo ./tracers/qemu_build.sh
fi

echo "***************************************"
echo "  Thanks for installing "
echo "  Check out README for more info"
echo "  enjoy it in CTF"
echo "    ~Ayumi"
echo "***************************************"
