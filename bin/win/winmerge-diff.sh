#!/bin/sh
# Use winmerge as mergetool for git in cygwin.
# 	git config --global difftool.winmerge.cmd "winmerge-diff.sh \"\$LOCAL\" \"\$REMOTE\" \"\$BASE\""
#   git config --global mergetool.winmerge.trustExitCode false
#   git difftool -t winmerge branch1..branch2   

# Reference: http://www.tldp.org/LDP/abs/abs-guide.pdf
# Reference: http://winmerge.org/docs/manual/CommandLine.html


library=githelperfunctions.sh

#[ -f $library ] && . $library
. $library

echo Launching winmerge.exe - winmerge-diff.sh: 

set_path_vars "$1" "$2" "$3" "$4"

"$winmergewinpath" /dl "LOCAL.$caption" /dr "TO_VERSION.$caption" "$localwinpath" "$remotewinpath" 