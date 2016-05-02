#!/bin/bash

echo -e "$(netstat -nr | grep "^0\.0\.0\.0" | awk '{print $2}')\tdockerhost" >> /etc/hosts &&
    export PATH=${PATH}:/opt/solidpostal
    for SCRIPT in /usr/local/src/*
    do
	${SCRIPT} &&
	    true
    done &&
    true
