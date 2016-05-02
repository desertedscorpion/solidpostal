#!/bin/bash

cat "${@}" > /var/lib/jenkins/credentials.xml &&
    chown jenkins:jenkins /var/lib/jenkins/credentials.xml &&
    chmod 0644 /var/lib/jenkins/credentials.xml &&
    true
