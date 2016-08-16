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
RMFCONFIG_PATH=/etc
TARGET_PATH=/opt
SCRIPT_PATH=$TDK_PATH
LOG_PATH=$TDK_PATH/logs
LOGFILE=tdkintegration_testmodule_prereq_details.log

mkdir -p $LOG_PATH
#removing old configuring status from the opt
rm $LOG_PATH/$LOGFILE

#Editing the rmf_config.ini to disbale the dtcp flag
rmf_flags="FEATURE.DTCP.SUPPORT FEATURE.MRDVR.MEDIASTREAMER.DLNA.DTCP.SUPPORT DTCP_IP_FORCE_ENCRYPTION"
for flag in $rmf_flags 
do
	FLAG_SEARCH_STATUS=`grep $flag $TARGET_PATH/rmfconfig.ini|wc -l`
	if [ $FLAG_SEARCH_STATUS -ne 0 ]
	then
	     echo $flag is found in rmfconfig.ini
	     #Editing the flag to false
	     sed -i -e 's/'$flag'=TRUE/'$flag'=FALSE/g' $TARGET_PATH/rmfconfig.ini
	     if [ $? -eq 0 ]
	     then
	     	echo "rmfconfig.ini file edited"
	     	touch $LOG_PATH/$LOGFILE
	     	echo  "SUCCESS" > $LOG_PATH/$LOGFILE
	     else
	        echo "sed utillity is not found"
	        touch $LOG_PATH/$LOGFILE
	        echo  "Failure<details>sed utillity is not found" > $LOG_PATH/$LOGFILE
	        exit 1
	     fi
	else
	     echo $flag "is not found in rmfconfig.ini"
	     touch $LOG_PATH/$LOGFILE
	     echo  "FAILURE<DETAILS>"$flag "is not found in rmfconfig.ini" > $LOG_PATH/$LOGFILE
	     exit 1
	fi
done

#Kill the Guide Application
/etc/init.d/xre-service stop
if [ $? -eq 0 ]
then
	echo  "xre stopped"
else
	echo "xre not stopped"
fi
#Check if rmfstreamer is running andad to Log file if Failure
echo "Going to check rmfStreamer"
VALUE=0
ps -ef | grep rmfStreamer | grep -v grep
if [[ "$?" = "$VALUE" ]]; then
        echo "rmfStreamer  running"
else
        echo "rmfStreamer not running"
         touch $LOG_PATH/$LOGFILE
        echo "FAILURE<details>RMF_STREAMER_NOT_RUNNING" > $LOG_PATH/$LOGFILE
        exit 1
fi                                                                                                                               

					
