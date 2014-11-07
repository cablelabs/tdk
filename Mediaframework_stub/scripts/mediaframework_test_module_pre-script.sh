RMFCONFIG_PATH=/etc
TARGET_PATH=/opt
SCRIPT_PATH=/opt/TDK
LOG_PATH=/opt/TDK/logs
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

#Restart the rmfstreamer,vodclient,podmanager & snmp
#process_name="rmf-streamer vod-service pod-service snmp-manager-service"
#for process in $process_name
#do
#	/etc/init.d/$process restart
#	if [ $? -eq 0 ]
#	then
#		echo $process "restarted"
#		touch $LOG_PATH/$LOGFILE
#		echo  "SUCCESS" > $LOG_PATH/$LOGFILE
#	else
#		echo $process "not able to restart"
#		touch $LOG_PATH/$LOGFILE
#		echo "FAILURE<DETAILS>" $process "not restarted" > $LOG_PATH/$LOGFILE
#		exit 1	
#	fi
#done

/etc/init.d/xre-service stop
if [ $? -eq 0 ]
then
	echo  "xre stopped"
else
	echo "xre not stopped"
fi
                                                                                                                                

					
