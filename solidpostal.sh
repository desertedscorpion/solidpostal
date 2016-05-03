#!/bin/bash

echo -e "$(netstat -nr | grep "^0\.0\.0\.0" | awk '{print $2}')\tdockerhost" >> /etc/hosts &&
    export PATH=${PATH}:/opt/solidpostal &&
    sleep 1m &&
    for SCRIPT in /usr/local/src/*	  
    do
	/usr/bin/bash ${SCRIPT} &&
	    true
    done &&
    true
