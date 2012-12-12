#!/bin/sh
# Use SourceGear DiffMerge as mergetool for git in cygwin.
# 	git config --global mergetool.diffmerge.cmd "diffmergetool.sh \"\$LOCAL\" \"\$REMOTE\" \"\$BASE\" \"\$MERGED\""
#   git config --global mergetool.diffmerge.trustExitCode false
#   git mergetool -t diffmerge

# Reference: http://www.tldp.org/LDP/abs/abs-guide.pdf

library=githelperfunctions.sh

#[ -f $library ] && . $library
. $library

echo Launching DiffMerge.exe - diffmerge-merge.sh: 

set_path_vars "$1" "$2" "$3" "$4"

"$diffmergewinpath" --merge -t1=FROM_VERSION -t2=MERGED -t3=TO_VERSION --result="$mergedwinpath" --caption="$caption" "$localwinpath" "$basewinpath" "$remotewinpath"

#unix2dos "$merged"

