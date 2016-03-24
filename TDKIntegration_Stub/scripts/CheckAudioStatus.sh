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

cmd=$(cat /opt/AVstatus.dat)
echo $cmd | grep 'Audio:SUCCESS' >>/dev/null
if [ $? -eq 0 ]
then
echo "SUCCESS"
else
echo "FAILURE"
fi

