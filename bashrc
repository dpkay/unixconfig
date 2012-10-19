# =========== SET UP UNIXCONFIG ===============
export COMMAND_OPEN="open"
export PATH=$UNIXCONFIG/bin:$PATH
export EDITOR=vim

# =========== TERMINAL COLORS ==============
NM="\[\033[0;38m\]" # means no background and white lines
HI="\[\033[0;37m\]" # change this for letter colors
HII="\[\033[0;31m\]" # change this for letter colors
SI="\[\033[0;33m\]" # this is for the current directory
IN="\[\033[0m\]"
export PS1="$NM[ $HI\u $HII\h $SI\w$NM ] $IN"

if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto -h'
    eval `dircolors $UNIXCONFIG/dir_colors`
fi

# =========== MAC SPECIFIC ===============
if [ "`uname`" == "Darwin" ]; then

  # MacVim
  if [ -e "`which mvim`" ]; then
    export VISUAL=mvim
  else
    export VISUAL=vim
  fi

  # MacPorts
  if [ -e "`which port`" ]; then
    export PATH=/opt/local/libexec/gnubin:/opt/local/bin:/opt/local/sbin:$PATH
    export MANPATH=/opt/local/share/man:$MANPATH
  fi

else
  # Not Mac, so presumably Linux or perhaps Windows
  export VISUAL=gvim
fi
  
# =========== ALIASES ===============
source "$UNIXCONFIG/alias_bash"

# =========== DOMAIN SPECIFIC ===============
if [ -e "$UNIXCONFIG/domain/bashrc" ]; then
  source $UNIXCONFIG/domain/bashrc
fi

