#!/bin/sh
# Use winmerge as mergetool for git in cygwin.
# 	git config --global mergetool.winmerge.cmd "winmerge-merge.sh \"\$LOCAL\" \"\$REMOTE\" \"\$BASE\" \"\$MERGED\""
#   git config --global mergetool.winmerge.trustExitCode false
#   git mergetool -t diffmerge

# Reference: http://www.tldp.org/LDP/abs/abs-guide.pdf
# Reference: http://winmerge.org/docs/manual/CommandLine.html

library=githelperfunctions.sh

#[ -f $library ] && . $library
. $library

echo Launching winmerge.exe - winmerge-merge.sh: 


set_path_vars "$1" "$2" "$3" "$4"

# -- use WinMergeU conflictFile
#"$winmergewinpath" "$mergedwinpath"
"$winmergewinpath" /dl "LOCAL.$caption" /dr "TO_VERSION.$caption" "$localwinpath" "$remotewinpath" 
