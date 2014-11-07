RMFCONFIG_PATH=/etc
TARGET_PATH=/opt
TDK_PATH=/opt/TDK
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

