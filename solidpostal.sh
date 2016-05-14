#!/bin/bash

echo -e "$(netstat -nr | grep "^0\.0\.0\.0" | awk '{print $2}')\tdockerhost" >> /etc/hosts &&
    export PATH=${PATH}:/opt/solidpostal/scripts &&
    export CLASSPATH=/usr/share/jenkins/webroot/WEB-INF/jenkins-cli.jar:/usr/share/jenkins/webroot/WEB-INF/remoting.jar:/opt/solidpostal/commons-codec-1.6.jar &&
    SCRIPT_COUNT=$(ls /opt/solidpostal/scripts/bin | wc --lines) &&
    if [ 0 == ${SCRIPT_COUNT} ]
    then
	echo "There are no scripts to execute." &&
	    true
    elif [ 0 != ${SCRIPT_COUNT} ]
    then
	echo "Executing ${SCRIPT_COUNT} scripts." &&
	   for SCRIPT in /opt/solidpostal/scripts/bin
	   do
	       echo "Executing \"${SCRIPT}" &&
	       while [[ "HTTP/1.1 200 OK" != $(curl --head http://127.0.0.1:8080 | head --lines 1 | tr -d "[:cntrl:]") ]]
	       do
		   echo "Waiting for jenkins to become available (either initially or after a safe-restart)." &&
		       sleep ${PRE_SLEEP} &&
		       true
	       done &&
		   /usr/bin/bash ${SCRIPT} &&
		   java hudson.cli.CLI -s http://127.0.0.1:8080 safe-restart &&
		   while [[ "HTTP/1.1 200 OK" == $(curl --head http://127.0.0.1:8080 | head --lines 1 | tr -d "[:cntrl:]") ]]
		   do
		       echo "Waiting for jenkins to shutdown (for a safe-restart)." && 
			   sleep ${POST_SLEEP} &&
			   true
		   done &&
		   true
	   done &&
	       true
    fi &&
    true
