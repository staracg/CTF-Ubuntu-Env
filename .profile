# You want $TERM to be screen-256color when tmux is running, and you want it to be xterm-256color when tmux is not running.
if [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; then
  export TERM=screen-256color
else
    export TERM=xterm-256color
fi

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

export PS1="\[$yellow$bold\]\u\[$reset\]@\[$green$bold\]\h\[$reset\]:\[$blue$bold\]\w\[$reset\]$ "

export HISTSIZE=50000
export CLICOLOR=1
export LSCOLORS='Exfxcxdxbxegedabagacad'
export EDITOR='vim'
export PATH="/usr/local/sbin:$PATH"
