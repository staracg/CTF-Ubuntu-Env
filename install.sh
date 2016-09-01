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
ask RC "Overwrite rc files? (y/n):"
ask CTF "Install CTF environment? (y/n):"

if $UPGRADE; then
    echo "UPGRADE"
    # Update everything
    sudo apt-get update
    sudo apt-get -y upgrade
    sudo apt-get -y dist-upgrade
    sudo apt-get -y autoremove
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

if $RC; then
    echo "RC"
    # Copy rc file
    sudo apt-get install -y vim
    sudo apt-get install build-essential cmake
    sudo apt-get install -y python-dev
    cp ./.vimrc ~
    cp ./.bashrc ~
    cp ./.bash_profile ~
    cp ./.screenrc ~
    # Install vim plugin
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
    cd ~/.vim/bundle/YouCompleteMe
    ./install.py --clang-completer --omnisharp-completer --gocode-completer --tern-completer --all
fi

if $CTF; then
    echo "CTF"
    # Install multi architecture
    dpkg --add-architecture i386
    sudo apt-get update
    sudo apt-get install -y gcc-multilib
    
    # Install angr
    sudo apt-get install python-dev libffi-dev build-essential virtualenvwrapper
    sudo pip install angr --upgrade

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

    # Install GDB peda
    cd ~/
    git clone https://github.com/longld/peda.git ~/peda
    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    echo "source ~/peda/peda.py" >> ~/.gdbinit
    echo "DONE! debug your program with gdb and enjoy"

    # Install python packages
    # stable
    # sudo pip install pwntools
    sudo pip install git+https://github.com/Gallopsled/pwntools#egg=pwntools --upgrade
    sudo pip install capstone --upgrade
    sudo pip install ropgadget --upgrade
    # Install qira
    cd ~/
    wget -qO- https://github.com/BinaryAnalysisPlatform/qira/archive/v1.2.tar.gz | tar zxvf qira/
    cd qira/
    sudo ./install.sh
    sudo ./fetchlibs.sh

fi
