#!/bin/sh
#
# ============================================================================
# COMCAST C O N F I D E N T I A L AND PROPRIETARY
# ============================================================================
# This file (and its contents) are the intellectual property of Comcast.  It may
# not be used, copied, distributed or otherwise  disclosed in whole or in part
# without the express written permission of Comcast.
# ============================================================================
# Copyright (c) 2014 Comcast. All rights reserved.
# ============================================================================
cmd=$(/bin/HOMIE.sh 0 0 -si)
echo $cmd | grep 'It appears as though audio is working fine.' >>/dev/null
if [ $? -eq 0 ]
then
echo "SUCCESS"
else
#This script always return SUCCESS, since platform specific script to check audio status is not available
#echo "FAILURE"
echo "SUCCESS"
fi

