# =========== SET UP UNIXCONFIG ===============
export PATH=$UNIXCONFIG/bin:$HOME_DIR_LOCAL/bin:$HOME_DIR/bin:/usr/local/bin:$PATH
export EDITOR=vim

# the following is not great. it should be HOME_DIR if google drive
# actually supported setting the sync directory
export UNIXCONFIG_DOMAIN="$HOME_DIR_LOCAL/cg/unixconfig_domain"

# =========== CXX MACROS ===================
export C1_DIR="$HOME_DIR_LOCAL"
export C2_DIR="$HOME_DIR_LOCAL"
export C3_DIR="$HOME_DIR_LOCAL"
export C4_DIR="$HOME_DIR_LOCAL"
export C5_DIR="$HOME_DIR_LOCAL"
alias c1='cd $C1_DIR'
alias c2='cd $C2_DIR'
alias c3='cd $C3_DIR'
alias c4='cd $C4_DIR'
alias c5='cd $C5_DIR'

# =========== TERMINAL COLORS ==============
NM="\[\033[0;38m\]" # means no background and white lines
HI="\[\033[0;37m\]" # change this for letter colors
HII="\[\033[0;31m\]" # change this for letter colors
SI="\[\033[0;33m\]" # this is for the current directory
IN="\[\033[0m\]"
export PS1="$NM[ $HI\u $HII\h $SI\w$NM ] $IN"

export TMUX_DEFAULT_PATH=
# =========== MAC SPECIFIC ===============
if [ "`uname`" == "Darwin" ]; then

  # MacPorts
  if [ -e "/opt/local/bin/port" ]; then
    export PATH=/opt/local/libexec/gnubin:/opt/local/bin:/opt/local/sbin:$UNIXCONFIG/bin/mac:$PATH
    export MANPATH=/opt/local/share/man:$MANPATH
    export TMUX_DEFAULT_PATH="reattach-to-user-namespace -l bash"
  fi

  # MacVim
  if [ -e "`which mvim`" ]; then
    export VISUAL=mvim
  else
    export VISUAL=vim
  fi
  export PLATFORM=mac

  # Raise maximum number of open files
  ulimit -S -n 2048

# ============ WINDOWS SPECIFIC ==========
elif [ ! -z `uname | grep CYGWIN` ] || [ ! -z `uname | grep MINGW` ]; then
  export PATH=$UNIXCONFIG/bin/win:$PATH
  export COMMAND_OPEN="cygstart"  
  export PLATFORM=windows

else
  if [ "`uname`" == "Linux" ]; then
    export PLATFORM=linux
  else
    export PLATFORM=unknown
  fi
  # Not Mac, so presumably Linux
  export VISUAL=gvim
  export COMMAND_OPEN="gnome-open"
fi
  
# =========== DIR COLORS ===============
if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto -h'
    eval `dircolors $UNIXCONFIG/dir_colors`
fi

# =========== ALIASES ===============
source "$UNIXCONFIG/alias_bash"

# =========== DOMAIN SPECIFIC ===============
if [ -e "$UNIXCONFIG_DOMAIN" ]; then
  source $UNIXCONFIG_DOMAIN/bashrc
fi

# =========== ADDITIONAL SCRIPT ===============
# git autocompletion
source "$UNIXCONFIG/bin/git-completion.bash"
