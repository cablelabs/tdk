#!/bin/sh
##########################################################################
# If not stated otherwise in this file or this component's Licenses.txt
# file the following copyright and licenses apply:
#
# Copyright 2016 RDK Management
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################################################################
RMFCONFIG_PATH=/etc
TARGET_PATH=/opt
TDK_PATH=$TARGET_PATH/TDK
SCRIPT_PATH=$TDK_PATH/scripts
LOG_PATH=$TDK_PATH/logs
LOGFILE=Mediaframework_testmodule_prereq_details.log

mkdir -p $LOG_PATH
#removing old configuring status from the opt
rm $LOG_PATH/$LOGFILE

#Copying the rmfconfig.ini file in to /opt/
if cp $RMFCONFIG_PATH/rmfconfig.ini $TARGET_PATH; then
   echo "rmfconfig.ini is copied from " $RMFCONFIG_PATH
else
   echo "rmfconfig.ini is not copied from " $RMFCONFIG_PATH 1>&2
   touch $LOG_PATH/$LOGFILE;
   echo "Failure<details>Not able to copy rmfconfig.ini" > $LOG_PATH/$LOGFILE
   exit 1
fi

#Editing the rmf_config.ini to disbale the dtcp flag
rmf_flags="FEATURE.DTCP.SUPPORT FEATURE.MRDVR.MEDIASTREAMER.DLNA.DTCP.SUPPORT DTCP_IP_FORCE_ENCRYPTION"
for flag in $rmf_flags
do
        FLAG_SEARCH_STATUS=`grep $flag $TARGET_PATH/rmfconfig.ini|wc -l`
        if [ $FLAG_SEARCH_STATUS -ne 0 ]
        then
             echo $flag is found in rmfconfig.ini
             if [ $flag == TRUE ]
             then
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
                echo $flag is already FALSE
                touch $LOG_PATH/$LOGFILE
                echo  "SUCCESS" > $LOG_PATH/$LOGFILE
             fi
        else
             echo $flag "is not found in rmfconfig.ini"
             touch $LOG_PATH/$LOGFILE
             echo  "FAILURE<DETAILS>"$flag "is not found in rmfconfig.ini" > $LOG_PATH/$LOGFILE
             exit 1
        fi
done

#Restart the rmfstreamer,vodclient,podmanager & snmp
#process_name="rmf-streamer vod-service pod-service snmp-manager-service"
#for process in $process_name
#do
#       /etc/init.d/$process restart
#       if [ $? -eq 0 ]
#       then
#               echo $process "restarted"
#               touch $LOG_PATH/$LOGFILE
#               echo  "SUCCESS" > $LOG_PATH/$LOGFILE
#       else
#               echo $process "not able to restart"
#               touch $LOG_PATH/$LOGFILE
#               echo "FAILURE<DETAILS>" $process "not restarted" > $LOG_PATH/$LOGFILE
#               exit 1
#       fi
#done

#Checking whether RMF streamer is running or not
echo "Going to check rmfStreamer"
VALUE=0
ps -ef | grep rmfStreamer | grep -v grep
if [[ "$?" = "$VALUE" ]]; then
echo "rmfStreamer running"
else
echo "rmfStreamer not running"
touch $LOG_PATH/$LOGFILE
echo "FAILURE<details>RMF_STREAMER_NOT_RUNNING" > $LOG_PATH/$LOGFILE
exit 1
fi

/etc/init.d/xre-service stop
if [ $? -eq 0 ]
then
        echo  "xre stopped"
else
        echo "xre not stopped"
fi                                                                                                                              

					
