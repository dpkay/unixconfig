
# =========== SET UP UNIXCONFIG ===============
export PATH=$UNIXCONFIG/bin:$HOME_DIR_LOCAL/bin:$HOME_DIR/bin:/usr/local/bin:/usr/local/android-sdk/platform-tools:/usr/local/android-sdk/tools:$PATH
export EDITOR=vim
export UNIXCONFIG_DOMAIN="$HOME_DIR/unixconfig_domain"
export TMUX_DEFAULT_PATH=
export PYTHONPATH=$HOME_DIR_LOCAL/appengine:$PYTHONPATH

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

# =========== MAC SPECIFIC ===============
if [ "`uname`" == "Darwin" ]; then

#  # MacPorts
#  if [ -e "/opt/local/bin/port" ]; then
#    export PATH=/opt/local/libexec/gnubin:/opt/local/bin:/opt/local/sbin:$UNIXCONFIG/bin/mac:$PATH
#    export MANPATH=/opt/local/share/man:$MANPATH
#  fi
  export HOMEBREW_ROOT=$HOME/homebrew
  export PATH=$UNIXCONFIG/bin/mac:$HOMEBREW_ROOT/bin:$HOMEBREW_ROOT/opt/coreutils/libexec/gnubin:$PATH
  export TMUX_DEFAULT_PATH="reattach-to-user-namespace -l bash"

  # MacVim
  if [ -e "`which mvim`" ]; then
    export VISUAL=mvim
  else
    export VISUAL=vim
  fi
  export COMMAND_OPEN="open"
  export PLATFORM=mac
  alias vim='mvim -v $@'

  # Araxis Merge command line utils
  if [ -d "/Applications/Araxis Merge.app/Contents/Utilities" ]; then
    export PATH=$PATH:/Applications/Araxis\ Merge.app/Contents/Utilities
  fi

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
  export VISUAL=vim
  export COMMAND_OPEN="xdg-open"
fi

# =========== DIR COLORS ===============
if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto -h'
    eval `dircolors $UNIXCONFIG/dir_colors`
fi

# =========== DOMAIN SPECIFIC ===============
if [ -e "$UNIXCONFIG_DOMAIN" ]; then
  source $UNIXCONFIG_DOMAIN/bashrc
fi

# =========== ADDITIONAL SCRIPTS ===============
source "$UNIXCONFIG/bin/git-completion.bash"
source "$UNIXCONFIG/bin/git-prompt.sh"

# =========== ALIASES ===============
source "$UNIXCONFIG/alias_bash"

# =========== TERMINAL COLORS ==============
NM="\[\033[0;38m\]" # means no background and white lines
HI="\[\033[0;37m\]" # change this for letter colors
HII="\[\033[0;31m\]" # change this for letter colors
GN="\[\033[0;32m\]" # change this for letter colors
SI="\[\033[0;33m\]" # this is for the current directory
IN="\[\033[0m\]"
export PS1=
export PS1="$PS1$NM[ "                     # White open bracket
export PS1="$PS1$HI\u"                     # Gray username
export PS1="$PS1$NM@"                      # White @
export PS1="$PS1$HII\h"                    # Red hostname
export PS1="$PS1$NM:"                      # White @
export PS1="$PS1$SI\w "                    # Brown path
export PS1="$PS1$GN\$(__git_ps1 \"%s \")"  # Git
export PS1="$PS1$NM] "                     # White close bracket
export PS1="$PS1$IN"                       # Reset font color


export CUDA_HOME=/usr/local/cuda-9.0
export PATH=${CUDA_HOME}/bin:${PATH}
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}
