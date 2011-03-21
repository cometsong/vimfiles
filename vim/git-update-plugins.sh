#!/bin/bash
#===============================================================================
#          FILE:  git-update-plugins.sh: 
#   DESCRIPTION:  go through each plugin dir and run:
#                   git fetch $*
#                   git merge FETCH_HEAD
#          BUGS:  ---
#        AUTHOR:  B.Leopold (cometsong) bleopold@uni-muenster.de
#       CREATED:  2011-03-21
#       LICENSE:  GPL v3+
#===============================================================================

# change this to match your installtion setup:
VIM_BUNDLE_DIR="$HOME/.vim/bundle"


#===============================================================================
# shell to the gits:
echo "Updating all the vim bundles in the directory:  $VIM_BUNDLE_DIR"

echo "Checking the list of bundles..."
BUNDLE_DIR_LIST=`ls ${VIM_BUNDLE_DIR}`

# list bundles (for debugging)
# echo "Vim Bundles:  " $BUNDLE_DIR_LIST

for RepoDir in ${BUNDLE_DIR_LIST[@]} ; do {
    cd "${VIM_BUNDLE_DIR}/${RepoDir}"
    echo "Working in $RepoDir..."
    git fetch $*
    git merge FETCH_HEAD
}
done

# All Done Now!
#===============================================================================
