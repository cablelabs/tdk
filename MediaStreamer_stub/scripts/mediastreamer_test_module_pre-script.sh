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
TARGET_PATH=/opt
TDK_PATH=/opt/TDK
LOG_PATH=$TDK_PATH/logs
LOGFILE=Mediastreamer_testmodule_prereq_details.log

mkdir -p $LOG_PATH
#removing old configuring status from the opt
rm $LOG_PATH/$LOGFILE

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
