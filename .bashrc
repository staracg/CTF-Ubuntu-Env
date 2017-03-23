# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more aliases
alias gdb="gdb -q"
alias tmux="tmux -2"
alias strace="strace -ixv"
alias ltrace="ltrace -iC"
alias len="expr length "
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vi='vim'
alias python='ipython'
alias objdump='objdump -M intel'

# Powerline set
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1

# Colorize the prompt.
yellow=$(tput setaf 3)
green=$(tput setaf 2)
blue=$(tput setaf 6)
bold=$(tput bold)
reset=$(tput sgr0)

# Setting
export TERM=screen-256color
export TERM=xterm-256color
export force_color_prompt=yes
export HISTSIZE=100000
export HISTFILESIZE=100000 
export PS1="\[$yellow$bold\]\u\[$reset\]@\[$green$bold\]\h\[$reset\]:\[$blue$bold\]\w\[$reset\]$ "
export CLICOLOR=1
export LSCOLORS='Exfxcxdxbxegedabagacad'
export EDITOR='vim'
