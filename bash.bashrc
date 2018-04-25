#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

function get_color_prompt {
  eXITSTATUS="$?"
  oFF="\[\e[0m\]"
  hOST="\h"
  dIR="\[\e[1;97m\]\W${oFF}"

  if [ $UID -eq 0 ]; then
    uSER="\[\e[0;31m\]\u"
    PS2="\[\e[0;31m\]-> ${oFF}"
  else
    uSER="\[\e[0;32m\]\u"
    PS2="\[\e[0;32m\]-> ${oFF}"
  fi

  if [ $eXITSTATUS -gt 0 ]; then
    eXITSTATUS="\[\e[1;41m\]:(\[\e[0;49m\] "
  else
    eXITSTATUS=""
  fi

  PS1="${eXITSTATUS}${uSER}${oFF}@${hOST} ${dIR} $ "
}

function get_plain_prompt {
  if [ "$?" -gt 0 ]; then
    xs=":( "
  else
    xs=""
  fi

  PS1="${xs}\u@\h \W $ "
  PS2="-> "
}

case ${TERM} in
  rxvt*)
    export EDITOR="gvim"
    alias su="urxvt -name \"Root_Term\" &"
    georgey
    ;;
  dumb)
    PROMPT_COMMAND=get_plain_prompt
    DISABLE_COLOR=1
    ;;
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*|screen)
    export EDITOR="gvim"
    georgey
    ;;
  *linux)
    export EDITOR="vim"
    georgey
    ;;
esac

PS3='-> '
PS4='+ '

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

# Use colors if applicable.
if [ ! $DISABLE_COLOR ]; then
    PROMPT_COMMAND=get_color_prompt
    if [ -f /etc/DIR_COLORS ]; then
        eval `dircolors /etc/DIR_COLORS`
    fi
    alias ls="ls --color"
fi

# Systemwide Aliases

alias sudo="sudo "
alias la="ls -A"
alias ll="la -lh"
alias x="exit"
alias bye="sudo shutdown -h now"
alias macmount="mount -t hfsplus -o force,rw"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
