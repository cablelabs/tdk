#!/bin/bash
INPUT="recordedlist.txt"
#INPUT=$1
while read line
do
if [[ "$line" =~ ['#'] ]]
    then
    echo -n $line 
    else
    echo  $line   
fi
done <$INPUT
