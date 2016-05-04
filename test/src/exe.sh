#!/bin/bash

credentials /usr/local/lib/credentials.xml &&
    ssh-key /var/private/id_rsa &&
    create-slave /usr/local/lib/slave.xml &&
    create-job /usr/local/lib/job.xml &&
    create-job /usr/local/lib/git1.xml &&
    create-job /usr/local/lib/git2.xml &&
    install-plugin git &&
    dnf install --assumeyes git &&
    export CLASSPATH=/usr/share/jenkins/webroot/WEB-INF/jenkins-cli.jar:/usr/share/jenkins/webroot/WEB-INF/remoting.jar:/usr/local/lib/commons-codec-1.6.jar &&
    java hudson.cli.CLI -s http://127.0.0.1:8080 build git1 &&
    java hudson.cli.CLI -s http://127.0.0.1:8080 build git2 &&
    true
