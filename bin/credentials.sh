#!/bin/bash

cat "${@}" > /var/lib/jenkins/credentials.xml &&
    chown jenkins:jenkins /var/lib/jenkins/credentials.xml &&
    chmod 0644 /var/lib/jenkins/credentials.xml &&
    export CLASSPATH=/usr/share/jenkins/webroot/WEB-INF/jenkins-cli.jar:/usr/share/jenkins/webroot/WEB-INF/remoting.jar:/usr/local/lib/commons-codec-1.6.jar &&
    java hudson.cli.CLI -s http://127.0.0.1:8080 safe-restart &&
    true
