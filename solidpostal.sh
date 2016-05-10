#!/bin/bash

echo -e "$(netstat -nr | grep "^0\.0\.0\.0" | awk '{print $2}')\tdockerhost" >> /etc/hosts &&
    export PATH=${PATH}:/opt/solidpostal/scripts &&
    sleep 1m &&
    for SCRIPT in /usr/local/src/*	  
    do
	/usr/bin/bash ${SCRIPT} &&
	    sleep 1m &&
	    java hudson.cli.CLI -s http://127.0.0.1:8080 safe-restart &&
	    sleep 1m &&
	    true
    done &&
    true
