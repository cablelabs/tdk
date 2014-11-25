echo "Stopping TDK Agent.."

sleep 1

#Killing inactive TDK processes
ps -ef | grep "agent" | grep -v "grep" | grep -v "tr69agent" | awk '{print $2}' | xargs kill -9 >& /dev/null
ps -ef | grep "tftp" | grep -v "grep" | awk '{print $2}' | xargs kill -9 >& /dev/null
ps -ef | grep "/opt/TDK/" | grep -v "grep" | awk '{print $2}' | xargs kill -9 >& /dev/null
sleep 2

echo "Done"
