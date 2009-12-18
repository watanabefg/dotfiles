# Created by newuser for 4.3.4
autoload -U compinit
compinit

# Language Settings
export LANG=ja_JP.UTF-8

# History Settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=100
setopt hist_ignore_dups
setopt share_history

# Prompt Settings
case ${UID} in
0)
PROMPT="%{^[[31m%}%n%%%{^[[m%}"
RPROMPT="[%~]"
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
PROMPT="%{^[[37m%}${HOST%%.*} ${PROMPT}"
;;
*)
PROMT="%{^[[31m%}%n%%%{^[[m%} "
RPROMPT="[%~]"
SPROMPT="%{^[[31m%}%r is correct? [n,y,a,e]:%{^[[m%} "
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
PROMPT="%{^[[37m%}${HOST%%.*} ${PROMPT}"
;;
esac

case "${TERM}" in
    kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

# Key Bind Setting
bindkey -e

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginngig-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# # Option Setting
setopt auto_pushd
setopt correct
setopt list_packed

# "^["はエスケープ
# viでは挿入モードでCtrl+v ESC

alias ls='ls -F'
alias ll='ls -l'
alias la='ls -a'
alias v='vim'
alias cp='cp -pi'
alias mv='mv -i'
alias h='history'

# for typo
alias lks='ls'
alias sl='ls'
alias ls\[='ls'
alias ls\]='ls'
alias pc='cp'
alias dc='cd'

DEV='/var/www/dev/'
CAKE='/var/www/cake/'
PATH=$PATH:/home/watanabefg/www/cake/cake/console/

### for 

