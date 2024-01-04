#!/usr/bin/bash

#Get the  first bytes of the Netowrk IP
ifconfig | grep "broadcast" | cut -d " " -f 10 | cut -d "." -f 1,2,3 | uniq > bytes.txt

#Setting a variable for  the value of bytes.txt
BYTES=$(cat bytes.txt)

#create a new .txt
echo "" > $BYTES.txt

#Loop
for ip in {1..254}
do 
	ping -c 1 $BYTES.$ip |grep "64 bytes" | cut -d " " -f 4 | tr -d ":" >> $BYTES.txt & 
done

wait

cat $BYTES.txt 

#Scan launching
nmap -sS -iL $BYTES.txt 

exit
