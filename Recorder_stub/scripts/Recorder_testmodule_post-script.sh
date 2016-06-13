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
#removing old configuring status from the opt
rm $TDK_PATH/logs/Recorder_testmodule_*

#removing the rmfconfig.ini file from /opt/
if rm $TARGET_PATH/rmfconfig.ini; then
   echo "rmfconfig.ini removed from "$TARGET_PATH
else
   echo "Cant able to remove rmfconfig.ini"
   touch $TDK_PATH/logs/Recorder_testmodule_postreq_details.log;
   echo "FAILURE<DETAILS>Not able to delete rmfconfig.ini" >> $TDK_PATH/logs/Recorder_testmodule_postreq_details.log

   exit 1
fi

#Restart the rmfstreamer,vodclient,podmanager & snmp
process_name="rmf-streamer vod-service pod-service snmp-manager-service"
for process in $process_name
do
        /etc/init.d/$process restart
        if [ $? -eq 0 ]
        then
                echo $process "restarted"
		touch $TDK_PATH/logs/Recorder_testmodule_postreq_details.log;
                echo "SUCCESS" >> $TDK_PATH/logs/Recorder_testmodule_postreq_details.log
        else
                echo $process "not able to restart"
   		touch $TDK_PATH/logs/Recorder_testmodule_postreq_details.log;
                echo "FAILURE<DEATILS>Not able to restart" $process >> $TDK_PATH/logs/Recorder_testmodule_postreq_details.log


        fi
done

