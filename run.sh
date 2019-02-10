#!/bin/bash

###########################################################################################
# Date         Version    Author             Description
#------------------------------------------------------------------------------------------
# 2019/02/10   1.0        Ousama BEN YOUNES  Git Rebase simple script 
###########################################################################################

DESTINATION_BRANCH="develop"
CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`

if [ "$DESTINATION_BRANCH" == "$CURRENT_BRANCH" ]; then
    echo "Current branch & destination branch are the same..."
    exit 0
fi

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

launch_cmd "git checkout $DESTINATION_BRANCH"
launch_cmd "git pull origin $DESTINATION_BRANCH"
launch_cmd "git checkout $CURRENT_BRANCH"
launch_cmd "git rebase $DESTINATION_BRANCH"
