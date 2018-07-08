# If not running interactively, don't do anything:
umask 002
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export HISTSIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
shopt -s histappend

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    case `uname` in
        Linux)
        eval `dircolors -b`
        alias ls='ls --color=auto'
        ;;
        Darwin)
        export CLICOLOR=1
        ;;
        SunOS)
        alias ls='ls -F' #close enough.
        ;;
    esac
fi

#delete words like csh
stty werase undef
bind '"\C-w": backward-kill-word'

# Git completion
export GIT_PS1_DESCRIBE_STYLE=branch
source ~/.git-completion.bash
source ~/.git-prompt.sh

#PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;35m\]$(__git_ps1 " «%s»")\[\033[00m\]\$ '
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w$(__git_ps1 " \[\033[01;34m\]«\[\033[01;35m\]%s\[\033[01;34m\]»")\[\033[00m\]\$ '
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

export TZ='America/Los_Angeles'
export PATH=$PATH:/usr/sbin:/sbin:~/bin:~/perl5/bin:/usr/local/sbin
export PAGER=/usr/bin/less

alias ljoin='perl -p0e "s/\n //g"'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

#eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)

[[ -x /Applications/MacVim.app/Contents/MacOS/Vim ]] && export PATH=/Applications/MacVim.app/Contents/MacOS:$PATH && alias vi=vim

if [ -e /Applications/MacVim.app/Contents/MacOS/Vim ]
then
  export EDITOR='/Applications/MacVim.app/Contents/MacOS/Vim'
else
  export EDITOR='vim'
fi

if [ -d /usr/local/etc/bash_completion.d ]
then
    source /usr/local/etc/bash_completion.d/*
fi

if [ -e ~/.env.local ]
then
    source ~/.env.local
fi

if [ -e ~/.bash.local ]
then
    source ~/.bash.local
fi

export PATH="$HOME/.cargo/bin:$PATH"
