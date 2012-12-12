#!/bin/sh
# Use SourceGear DiffMerge as mergetool for git in cygwin.
# 	git config --global mergetool.diffmerge.cmd "diffmergetool.sh \"\$LOCAL\" \"\$REMOTE\" \"\$BASE\" \"\$MERGED\""
#   git config --global mergetool.diffmerge.trustExitCode false
#   git difftool -t diffmerge branch1..branch2

# Reference: http://www.tldp.org/LDP/abs/abs-guide.pdf

library=githelperfunctions.sh

#[ -f $library ] && . $library
. $library

echo Launching DiffMerge.exe - diffmerge-diff.sh: 

set_path_vars "$1" "$2" "$3" "$4"

echo "$diffmergewinpath" -t1=FROM_VERSION -t2=TO_VERSION --caption=$caption $localwinpath $remotewinpath
"$diffmergewinpath" -t1=FROM_VERSION -t2=TO_VERSION --caption="$caption" "$localwinpath" "$remotewinpath"
