# export GPG_TTY=$(tty)
# gpgconf --launch gpg-agent

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[1;32m\]\[\033[0m\033[1;32m\]\u\[\033[1;36m\] @ \[\033[1;36m\]\h \w\[\033[1;32m\]\n\[\033[1;32m\]└─\[\033[0m\033[1;32m\] \$\[\033[0m\033[1;32m\] ▶\[\033[0m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w🔑 '
fi


unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


#PERSO

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias ~='cd ~'
alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'

# Easy report
alias ls='ls -Fh --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias l='ls -l'
alias ll='ls -la'
alias la='ls -lA'
alias lr='ls -R'
alias lf='ls -l | grep "^-"'
alias l.f='ls -ld .* | grep "^-"'
alias ld='ls -l | grep "^d"'
alias l.d='ls -ld .* | grep "^d"'
alias dud='du -d 1 -h'
alias duf='du -sh *'
alias fdir='find . -type d -name'
alias ff='find . -type f -name'
alias h='history'
alias hgrep='history | grep'
alias lgrep='ls -l | grep'
alias lagrep='ls -lA | grep'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,.tldr,node_modules,Trash,vendor}'
alias cp='cp -iv'
alias mv='mv -iv'
alias ln='ln -iv'
alias mkdir='mkdir -v'
alias rm='rm -i'
alias rmf='rm -rf'
alias p='ps axo pid,user,pcpu,comm'
alias uptime='uptime -p'
alias free='free -h'
alias disk='df -h | grep sd \
    | sed -e "s_/dev/sda[1-9]_\x1b[34m&\x1b[0m_" \
    | sed -e "s_/dev/sd[b-z][1-9]_\x1b[33m&\x1b[0m_" \
    | sed -e "s_[,0-9]*[MG]_\x1b[36m&\x1b[0m_" \
    | sed -e "s_[0-9]*%_\x1b[32m&\x1b[0m_" \
    | sed -e "s_9[0-9]%_\x1b[31m&\x1b[0m_" \
    | sed -e "s_/mnt/[-_A-Za-z0-9]*_\x1b[34;1m&\x1b[0m_"'
alias alu='apt list --upgradable'
alias preview='fzf --height=50% --layout=reverse --preview="bat --color=always {}"'

# Bookmarks
alias dl='cd ~/Téléchargements && ls -lA'
alias doc='cd ~/Documents && ls -lA'

# Shortcuts
alias c='clear'
#alias cat='bat'
alias ch='echo > ~/.bash_history && echo > ~/.zsh_history'
alias cz='echo > ~/.z'
alias e='exit'
alias htop-user='htop -u "$USER"'
alias incognito='unset HISTFILE'
alias ip-address='curl -s -H "Accept: application/json" https://ipinfo.io/json | jq "del(.loc, .postal)"'
alias mp3-dl='youtube-dl --ignore-config --extract-audio \
    --audio-format "mp3" --audio-quality 0 --embed-thumbnail \
    --add-metadata --metadata-from-title "%(artist)s - %(title)s" \
    --output "$HOME/Downloads/%(title)s.%(ext)s"'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias timer='echo "Timer started. Stop with Ctrl-D." && date "+%a, %d %b %H:%M:%S" && time cat && date "+%a, %d %b %H:%M:%S"'
alias tldr='tldr -t base16'


alias maj="sudo apt update && sudo apt dist-upgrade"
alias tt="watch sensors"
alias flic="sudo nmap -v -Pn -A"
alias log="sudo tailf /var/log/messages | ccze -A"
alias search='apt-cache search'


############################################

mkcd ()
{
  mkdir -p -- "$1" && cd -P -- "$1"
}


#Man en couleur
man() {
     env \
     LESS_TERMCAP_mb=$'\E[01;31m' \
     LESS_TERMCAP_md=$'\E[01;38;5;74m' \
     LESS_TERMCAP_me=$'\E[0m' \
     LESS_TERMCAP_se=$'\E[0m' \
     LESS_TERMCAP_so=$'\E[1;44;33m' \
     LESS_TERMCAP_ue=$'\E[0m' \
     LESS_TERMCAP_us=$'\E[04;38;5;146m' \
     man "$@"
}


lesslog() { ccze -A < $1 | less -R; }
logtail() { tail -f $1 | ccze -A; }


alias glog='git log --pretty="format:%h %G? %aN %d %s"'
alias gglog='git log -all --oneline --graph'


alias allg='git add . && git commit -m ${1} && git push'


# Ne pas enregistrer les commandes qui commencent par un espace
export HISTCONTROL="ignorespace"
# Ne pas afficher les commandes dupliquées qui se suivent
export HISTCONTROL="ignoredups"
# A le même effet que les deux commandes précédente
export HISTCONTROL="ignoreboth"
# Supprime toutes les commandes dupliquées (même celles qui ne se suivent pas)
export HISTCONTROL="erasedups"
# Efface les commandes dupliquées, n'enregistre pas les commandes qui commencent par un espace
export HISTCONTROL="erasedups:ignorespace"

# On ignore les commandes ls et cd de l'historique
export HISTIGNORE="ls*:cd*"

alias delhisto='history -cw'
export HISTTIMEFORMAT="%d/%m/%Y %H:%M:%S "
