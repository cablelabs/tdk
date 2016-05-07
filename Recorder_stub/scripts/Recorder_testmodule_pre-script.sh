RMFCONFIG_PATH=/etc/
TARGET_PATH=/opt/
#removing old configuring status from the opt
rm $TDK_PATH/logs/Recorder_testmodule_prereq_details.log

#Copying the rmfconfig.ini file in to /opt/
ls $TARGET_PATH/rmfconfig.ini
if [ $? == 0 ]; then
        echo "file present"
else
        if cp $RMFCONFIG_PATH/rmfconfig.ini $TARGET_PATH; then
           echo "rmfconfig.ini is copied from " $RMFCONFIG_PATH
        else
           echo "rmfconfig.ini is not copied from " $RMFCONFIG_PATH 1>&2
           touch $TDK_PATH/logs/Recorder_testmodule_prereq_details.log;
           echo "FAILURE<DETAILS>Unable to copy rmfconfig.ini" >> $TDK_PATH/logs/Recorder_testmodule_prereq_details.log
           exit 1
        fi
fi

#Editing the rmf_config.ini to change the server URL
rmf_flags="FEATURE.LONGPOLL.URL"
IP=$(awk -F"@" '/Manager IP/{ip=$2}END{print ip}' $TDK_PATH/tdkconfig.ini )
echo $IP
FLAG_SEARCH_STATUS=`grep $rmf_flags=http://$IP:8080/DVRSimulator/longpollServer $TARGET_PATH/rmfconfig.ini|wc -l`
if [ $FLAG_SEARCH_STATUS -ne 0 ]
then
     echo $rmf_flags "is found in rmfconfig.ini"
else
     #Editing the rmf_config.ini to change the server URL
     sed -i -e "s#$rmf_flags=.*#$rmf_flags=http://$IP:8080/DVRSimulator/longpollServer#g" $TARGET_PATH/rmfconfig.ini
     if [ $? -eq 0 ]
     then
        echo "rmfconfig.ini file edited for" $rmf_flags
        REBOOT="TRUE"
     else
        echo "sed utillity is not found"
        touch $TDK_PATH/logs/Recorder_testmodule_prereq_details.log;
        echo  "FAILURE<DETAILS>sed utillity is not found" >> $TDK_PATH/logs/Recorder_testmodule_prereq_details.log
        exit 1
     fi
fi
rmf_flags="FEATURE.RWS.POST.URL"
FLAG_SEARCH_STATUS=`grep $rmf_flags=http://$IP:8080/DVRSimulator/recorder/status $TARGET_PATH/rmfconfig.ini|wc -l`
if [ $FLAG_SEARCH_STATUS -ne 0 ]
then
     echo $rmf_flags "is found in rmfconfig.ini"
else
     #Editing the rmf_config.ini to change the server URL
     IP=$(awk -F"@" '/Manager IP/{ip=$2}END{print ip}' $TDK_PATH/tdkconfig.ini )
     echo $IP
     sed -i -e "s#$rmf_flags=.*#$rmf_flags=http://$IP:8080/DVRSimulator/recorder/status#g" $TARGET_PATH/rmfconfig.ini
     if [ $? -eq 0 ]
     then
        echo "rmfconfig.ini file edited for" $rmf_flags
        REBOOT="TRUE"
     else
        echo "sed utillity is not found"
        touch $TDK_PATH/logs/Recorder_testmodule_prereq_details.log;
        echo  "FAILURE<DETAILS>sed utillity is not found" >> $TDK_PATH/logs/Recorder_testmodule_prereq_details.log
        exit 1
     fi
fi

rmf_flags="FEATURE.SECURE_RWS.POST.URL"
FLAG_SEARCH_STATUS=`grep $rmf_flags=http://$IP:8080/DVRSimulator/recorder/status $TARGET_PATH/rmfconfig.ini|wc -l`
if [ $FLAG_SEARCH_STATUS -ne 0 ]
then
     echo $rmf_flags "is found in rmfconfig.ini"
else
     #Editing the flag to false
     IP=$(awk -F"@" '/Manager IP/{ip=$2}END{print ip}' $TDK_PATH/tdkconfig.ini )
     echo $IP
     sed -i -e "s#$rmf_flags=.*#$rmf_flags=http://$IP:8080/DVRSimulator/recorder/status#g" $TARGET_PATH/rmfconfig.ini
     if [ $? -eq 0 ]
     then
        echo "rmfconfig.ini file edited"
        REBOOT="TRUE"
     else
        echo "sed utillity is not found"
        touch $TDK_PATH/logs/Recorder_testmodule_prereq_details.log;
        echo  "FAILURE<DETAILS>sed utillity is not found" >> $TDK_PATH/logs/Recorder_testmodule_prereq_details.log
        exit 1
     fi
fi
rmf_flags="FEATURE.RWS.GET.URL"
FLAG_SEARCH_STATUS=`grep $rmf_flags=http://$IP:8080/DVRSimulator/recorder/updateSchedule $TARGET_PATH/rmfconfig.ini|wc -l`
if [ $FLAG_SEARCH_STATUS -ne 0 ]
then
     echo $rmf_flags is found in rmfconfig.ini
else
     #Editing the rmf_config.ini to change the server URL
     IP=$(awk -F"@" '/Manager IP/{ip=$2}END{print ip}' $TDK_PATH/tdkconfig.ini )
     echo $IP
     sed -i -e "s#$rmf_flags=.*#$rmf_flags=http://$IP:8080/DVRSimulator/recorder/updateSchedule#g" $TARGET_PATH/rmfconfig.ini
     if [ $? -eq 0 ]
     then
        echo "rmfconfig.ini file edited for" $rmf_flags
        REBOOT="TRUE"
     else
        echo "sed utillity is not found"
        touch $TDK_PATH/logs/Recorder_testmodule_prereq_details.log;
        echo  "FAILURE<DETAILS>sed utillity is not found" >> $TDK_PATH/logs/Recorder_testmodule_prereq_details.log
        exit 1
     fi
fi

rmf_flags="FEATURE.SECURE_RWS.GET.URL"
FLAG_SEARCH_STATUS=`grep $rmf_flags=http://$IP:8080/DVRSimulator/recorder/updateSchedule $TARGET_PATH/rmfconfig.ini|wc -l`
if [ $FLAG_SEARCH_STATUS -ne 0 ]
then
     echo $rmf_flags is found in rmfconfig.ini
else
     #Editing the flag to false
     IP=$(awk -F"@" '/Manager IP/{ip=$2}END{print ip}' $TDK_PATH/tdkconfig.ini )
     echo $IP
     sed -i -e "s#$rmf_flags=.*#$rmf_flags=http://$IP:8080/DVRSimulator/recorder/updateSchedule#g" $TARGET_PATH/rmfconfig.ini
     if [ $? -eq 0 ]
     then
        echo "rmfconfig.ini file edited"
        REBOOT="TRUE"
     else
        echo "sed utillity is not found"
        touch $TDK_PATH/logs/Recorder_testmodule_prereq_details.log;
        echo  "FAILURE<DETAILS>sed utillity is not found" >> $TDK_PATH/logs/Recorder_testmodule_prereq_details.log
        exit 1
     fi
fi

rmf_flags="FEATURE.LONGPOLL.END.POINT"
FLAG_SEARCH_STATUS=`grep $rmf_flags=http://$IP:8080/DVRSimulator/longpollEndPoint $TARGET_PATH/rmfconfig.ini|wc -l`
if [ $FLAG_SEARCH_STATUS -ne 0 ]
then
     echo $rmf_flags is found in rmfconfig.ini
else
     #Editing the rmf_config.ini to change the server URL
     IP=$(awk -F"@" '/Manager IP/{ip=$2}END{print ip}' $TDK_PATH/tdkconfig.ini )
     sed -i "/FEATURE.LONGPOLL.URL/ a $rmf_flags=http://$IP:8080/DVRSimulator/longpollEndPoint" $TARGET_PATH/rmfconfig.ini
     if [ $? -eq 0 ]
     then
        echo "rmfconfig.ini file edited"
        REBOOT="TRUE"
     else
        echo "sed utillity is not found"
        touch $TDK_PATH/logs/Recorder_testmodule_prereq_details.log;
        echo  "FAILURE<DETAILS>sed utillity is not found" >> $TDK_PATH/logs/Recorder_testmodule_prereq_details.log
        exit 1
     fi
fi
if [[ $REBOOT == "TRUE" ]]
then
     touch $TDK_PATH/logs/Recorder_testmodule_prereq_details.log;
     echo  "<REBOOT> : rmfconfig.ini is changed" >> $TDK_PATH/logs/Recorder_testmodule_prereq_details.log
     echo  "<REBOOT> : rmfconfig.ini is changed"
else
     touch $TDK_PATH/logs/Recorder_testmodule_prereq_details.log;
     echo  "SUCCESS<DETAILS>" $rmf_flags "is already set to appropriate server" >> $TDK_PATH/logs/Recorder_testmodule_prereq_details.log
     echo  "SUCCESS<DETAILS>" $rmf_flags "is already set to appropriate server"
fi

