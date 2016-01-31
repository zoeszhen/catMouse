#!/bin/bash
source nc_port_number
source listy_location

while true 
do
ssh $listynode nc -l $listy_port >> cmsg #put the output into cmsg file
done
