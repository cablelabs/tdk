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
