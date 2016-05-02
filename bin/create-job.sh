#!/bin/bash

export CLASSPATH=/usr/share/jenkins/webroot/WEB-INF/jenkins-cli.jar:/usr/share/jenkins/webroot/WEB-INF/remoting.jar:/usr/local/lib/commons-codec-1.6.jar &&
    cat "${@}" | java hudson.cli.CLI -s http://127.0.0.1:8080 create-job $(basename "${@%.*}") &&
    true
