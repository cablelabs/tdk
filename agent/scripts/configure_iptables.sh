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
