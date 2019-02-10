#!/bin/bash



DESTINATION="develop"
CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`


##################################################################
# Purpose: Launch given command, print it or exit if error occurs
# Arguments:
#   $1 (CMD) -> the given command 
##################################################################
function launch_cmd() 
{
    local CMD=$1   
    now=$(date)
    echo "[INFO] [$now] cmd => $CMD"
    eval $CMD
    retval=$?    
    if [ $retval -ne 0 ]; then
        echo "[Error] failed. Exiting..."
        exit $retval
    fi
}

launch_cmd "git checkout $DESTINATION"
launch_cmd "git pull origin $DESTINATION"
launch_cmd "git checkout $CURRENT_BRANCH"
launch_cmd "git rebase $DESTINATION"
