LOGPATH=/opt/TDK/
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
