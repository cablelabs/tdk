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
#
#Get the interface to connect to WAN. This is stored in the $INTERFACE variable in common.properties file
#source /sysint/conf/common.properties
source /etc/common.properties

#The below variables hold the port numbers used by the agent in the client.
CLIENT_AGENT_PORT=8087
CLIENT_STATUS_PORT=8088
CLIENT_TFTP_PORT=69
CLIENT_AGENT_MONITOR_PORT=8090

#This is the interface on gateway device corresponding to the MoCA network.
HOME_NETWORK_INTERFACE="eth1"

#Set the below variable to the interface that provides LAN connectivity
#GATEWAY_BOX_WAN_INTERFACE="lan0"
GATEWAY_BOX_WAN_INTERFACE=$(echo $INTERFACE | awk -F":" '{print $1}') 

echo "Configuring iptables... "
if [ $# -lt 5 ]; then
	echo "Error! Insufficient arguments. Format is $0 <client MAC address> <agent port> <status monitoring port> <tftp port> <agent monitoring port>"
	exit 1
fi

#The below variables represent the MAC and port details of the gateway box.
#These forwarding works as below:
#FWD_AGENT_PORT on gateway is forwarded to CLIENT_AGENT_PORT.
#FWD_STATUS_PORT on gateway is forwarded to CLIENT_STATUS_PORT.
#FWD_TFTP_PORT  on gateway is forwarded to CLIENT_TFTP_PORT.
#FWD_AGENT_MONITOR_PORT  on gateway is forwarded to CLIENT_AGENT_MONITOR_PORT.

CLIENT_MAC=$1
FWD_AGENT_PORT=$2
FWD_STATUS_PORT=$3
FWD_TFTP_PORT=$4
FWD_AGENT_MONITOR_PORT=$5

echo "Done."
