#!/bin/bash

source nc_port_number
echo "I am a mouse runing on $mouse_nc_port"
nc -l $nc_port_number | while read line #listen to the nc port
	do 
		message=$(echo $line|grep -c 'MEOW') #If the message contain NEOW
			if [[ $message -eq 1]]; then
				catPID=`ps -u $USER |grep chase_cat.sh | awk '{print $1}'`#get the cat pid
				mousePID=`ps -u $USER |grep mouse.sh | awk '{print $1}'`#get the mouse pid
				if [[[ ! -z $catPID ] && [ ! -z $mousePID ]]];then
					kill -SIGINT $catPID #send SIGINT to cat
					kill -SIGINT $mousePID #kill the mouses
				fi
			fi
	done