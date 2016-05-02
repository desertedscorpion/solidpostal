#!/bin/bash

echo -e "$(netstat -nr | grep "^0\.0\.0\.0" | awk '{print $2}')\tdockerhost" >> /etc/hosts &&
    cp /usr/local/src/credentials.xml /var/lib/jenkins &&
    chown jenkins:jenkins /var/lib/jenkins/credentials.xml &&
    chmod 0644 /var/lib/jenkins/credentials.xml &&
    mkdir /var/lib/jenkins/.ssh &&
    chown jenkins:jenkins /var/lib/jenkins/.ssh &&
    chmod 0700 /var/lib/jenkins/.ssh &&
    cp /usr/local/src/id_rsa /var/lib/jenkins/.ssh &&
    chown jenkins:jenkins /var/lib/jenkins/.ssh/id_rsa &&
    chmod 0600 /var/lib/jenkins/.ssh/id_rsa &&
    export CLASSPATH=/usr/share/jenkins/webroot/WEB-INF/jenkins-cli.jar:/usr/share/jenkins/webroot/WEB-INF/remoting.jar:/usr/local/lib/commons-codec-1.6.jar &&
    for FILE in /usr/local/src/slaves/*
    do
	cat ${FILE} | java hudson.cli.CLI -s http://127.0.0.1:8080 create-node $(basename ${FILE%.*}) &&
	    sleep 10s &&
	    true
    done &&
    for FILE in /usr/local/src/jobs/*
    do
	cat ${FILE} | java hudson.cli.CLI -s http://127.0.0.1:8080 create-job $(basename ${FILE%.*}) &&
	    sleep 10s &&
	    true
    done &&
    true
