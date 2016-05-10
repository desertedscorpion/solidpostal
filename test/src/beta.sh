#!/bin/bash

export CLASSPATH=/usr/share/jenkins/webroot/WEB-INF/jenkins-cli.jar:/usr/share/jenkins/webroot/WEB-INF/remoting.jar:/usr/local/lib/commons-codec-1.6.jar &&
    dnf install --assumeyes git &&
    java hudson.cli.CLI -s http://127.0.0.1:8080 build git1 &&
    java hudson.cli.CLI -s http://127.0.0.1:8080 build job2 &&
