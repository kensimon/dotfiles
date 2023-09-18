# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME=""

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
DISABLE_LS_COLORS="false"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git docker)

# Worst.  feature.  ever.
DISABLE_AUTO_UPDATE="true"

# Set history options both before and after sourcing oh-my-zsh, because omzsh will overwrite it.
setopt no_share_history
setopt inc_append_history
export HISTSIZE=999999999
export SAVEHIST=999999999

source $ZSH/oh-my-zsh.sh

setopt no_share_history
setopt inc_append_history
export HISTSIZE=999999999
export SAVEHIST=999999999

alias vi=vim

if which nvim >/dev/null 2>&1; then
    alias vim=nvim
    export EDITOR=nvim
elif which mvim >/dev/null 2>&1; then
    alias vim='mvim -v'
    export EDITOR='mvim -v'
else
    export EDITOR='vim'
fi

# ohmyzsh's colors are ugly
unset LSCOLORS

# Make the tab title the same as the window title (I want to see the hostname
# I'm on when I have lots of tabs, but the default just shows PWD.)
ZSH_THEME_TERM_TAB_TITLE_IDLE="%n@%m: %~"

# do not bell on tab-completion
#set bell-style none

# Make OSX cursor movement shortcuts work, unobtrusively (default bash ones
# still work too.)
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\e[5D" backward-word
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
bindkey "\e[1;9C" forward-word
bindkey "\e[1;9D" backward-word

# for rxvt
bindkey "\e[8~" end-of-line

# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line

# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

# Make !$ and friends just work without having to hit enter twice.  (I live
# dangerously.)
setopt no_hist_verify

# I don't really like zsh's autocorrect.
setopt nocorrect
setopt nocorrectall

# And I have no idea why anybody would want zsh to just guess on an
# unambiguation when you type a prefix.
bindkey "^I" expand-or-complete

export PATH=$PATH:/usr/local/sbin

# Setup rbenv (needs to be done before oh-my-zsh for the prompt to work with
# rbenv.)
if [ -e ~/.rbenv ]; then
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi

# Golang stuff
export GOPATH=$HOME/dev/go
export PATH=$PATH:$GOPATH/bin

# For system-specific stuff I don't want in my dotfiles repo
if [ -e "${HOME}/.env.local" ]; then
    source "${HOME}/.env.local"
fi

# Place my theme in my dotfiles dir so I don't have to maintain a downstream
# fork of oh-my-zsh.
source $HOME/.dotfiles/ken.zsh-theme

# Don't save the "fg" command to history, using a trick where zsh doesn't
# commit to history anything with a leading space.
alias fg=' fg'

alias npm-exec='PATH=$(npm bin):$PATH'

source ~/.kcfg.zsh
source ~/.kubectl.zsh
source ~/.gopa.zsh

function cdggh() {
    cd "${GOPATH}/src/github.com/${1}"
}
_cdggh() {
  _files -W "${GOPATH}/src/github.com"
}

function waitandsaywhendone() {
    while :; do pgrep -qf "${1}" || { say "It's done" && break }; sleep 1; done
}

compdef _cdggh cdggh

alias json2yaml='ruby -rjson -ryaml -e "puts JSON.load(\$stdin.read.to_s).to_yaml"'
alias yaml2json='ruby -rjson -ryaml -e "puts YAML.load(\$stdin.read.to_s).to_json"'
alias datestamp='date "+%Y%m%d%H%M"'
alias lcase='tr "A-Z" "a-z"'

# Rust stuff
export PATH="${PATH}:${HOME}/.cargo/bin"
if [[ -z "${TMUX}" ]]
then
    DISABLE_AUTO_TITLE=true
fi
