#!/bin/bash
source listy_location
source nc_port_number
message="$1" #the command from cordy
namecat="$2" #the name of cat
portname="$3" #port number

if [[ "$message" = "S" ]] #if the cordy give the searching command
        then
        echo "$namecat is searching on $portname"
        mousePID=`ssh $portname "ps aux| pgrep mouse.sh"` #if the mouse pid is not empty 
                if [[ ! -z $mousePID ]]   #found mouse
                                then
                                sleep 12  
                                echo "$namecat find mouse on $portname"
                                echo "F $portname $namecat" | nc $listynode $listy_port #send F message to listy so that listy will record to cmsg
								# F ukkonode73  Jazzy

                else                   #not found yet
                                echo "N $portname $namecat" | nc $listynode $listy_port #send N message to listy so that listy will record to cmsg
								# N ukkonode73  Jazzy
                                sleep 12   #search need 12 seconds                              
                                echo "No mouse on here!!!"
                fi
                exit 0
else if            #if the cordy give the attacking command
        echo "Mouse has been attacked by $namecat on $portname"
        sleep 6 
        echo "MEOW" ; sleep 8  | nc $3 $mouse_port  #send MEOW to mouse 
        trap "SIGINT" && echo "mouse is dead now"   # cat receive SIGINT from mouse  
        echo "G $portname $namecat" | nc $listynode $listy_port
fi
fi

