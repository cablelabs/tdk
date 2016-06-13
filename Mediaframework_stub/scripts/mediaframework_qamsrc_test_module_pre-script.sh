#####################################################################
#
# COMCAST PROPRIETARY AND CONFIDENTIAL
# __________________
#
#  Copyright 2015 Comcast Cable Communications Management, LLC
#  All Rights Reserved.
#
# NOTICE:  All information contained herein is, and remains the property of Comcast
# and its suppliers, if any.  The concepts contained herein are proprietary to Comcast
# and its suppliers and may be covered by U.S. and foreign patents or patents in process,
# and are protected by trade secret or copyright law.  Dissemination of this information
# or reproduction of this material is strictly forbidden without prior written permission
# from Comcast.
#
#####################################################################
LOGPATH=$TDK_PATH
LOGFILE=logs/Mediaframework_qamsrc_testmodule_postreq_details.log
rm $LOGPATH/$LOGFILE
touch $LOGPATH/$LOGFILE

ps | grep monitorRMF.sh|grep -v grep|awk '{print $1};'|xargs kill -9
if [ $? == 0 ]; then
	echo "monitorRMF is killed"
	echo "SUCCESS" > $LOGPATH/$LOGFILE
else	
	echo "monitorRMF is not running"
	echo "SUCCESS" > $LOGPATH/$LOGFILE
fi

ps | grep rmfStreamer |grep -v grep|awk '{print $1};'|xargs kill -9
if [ $? == 0 ]; then
        echo "rmfstreamer is killed"
        echo "SUCCESS" > $LOGPATH/$LOGFILE
else
	echo "rmfstreamer is not running"
	echo "SUCCESS" > $LOGPATH/$LOGFILE        
fi
cp /etc/rmfconfig.ini $LOGPATH/
cp /etc/debug.ini $LOGPATH/
