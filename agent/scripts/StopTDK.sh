echo "Stopping TDK Agent.."

sleep 1

#Killing inactive TDK processes
ps | grep "agent" | grep -v "grep" | grep -v "tcf-agent" | awk '{print $1}' | xargs kill -9 >& /dev/null
ps | grep "tftp" | grep -v "grep" | awk '{print $1}' | xargs kill -9 >& /dev/null
ps | grep "/opt/TDK/" | grep -v "grep" | awk '{print $1}' | xargs kill -9 >& /dev/null
sleep 2

echo "Done"
