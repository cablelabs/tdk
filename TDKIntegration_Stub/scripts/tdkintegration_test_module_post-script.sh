RMFCONFIG_PATH=/etc
TARGET_PATH=/opt
LOGPATH=$TDK_PATH/logs
LOGFILE=tdkintegration_testmodule_postreq_details.log
#Create if log file not there
mkdir -p $LOGPATH

#removing old configuring status from the opt
rm $LOGPATH/$LOGFILE

#removing the rmfconfig.ini file from /opt/
if rm $TARGET_PATH/rmfconfig.ini; then
   echo "rmfconfig.ini removed from "$TARGET_PATH
else
   echo "Cant able to remove rmfconfig.ini"
   touch $LOGPATH/$LOGFILE
   echo "FAILURE<details>Not able to delete rmfconfig.ini" > $LOGPATH/$LOGFILE
          
   exit 1
fi

#Restart the rmfstreamer,vodclient,podmanager & snmp to use the original rmfconfig.ini
process_name="rmf-streamer vod-service pod-service snmp-manager-service"
for process in $process_name
do
	/etc/init.d/$process restart
	if [ $? -eq 0 ]
	then
		echo $process "restarted"
		touch $LOGPATH/$LOGFILE;
		echo "SUCCESS" > $LOGPATH/$LOGFILE
	else
		echo $process "not able to restart"
		touch $LOGPATH/$LOGFILE;
		echo "FAILURE<details>Not able to restart" > $LOGPATH/$LOGFILE
		
	fi
done

/etc/init.d/xre-service start
if [ $? -eq 0 ]
then
        echo  "xre stared"
else
        echo "xre not started"
fi
                		
		                          
					
