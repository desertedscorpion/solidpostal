#!/bin/bash

./ssh-dir.ssh &&
    cat "${@}" >> /var/lib/jenkins/.ssh/config &&
    chown jenkins:jenkins /var/lib/jenkins/.ssh/config &&
    chmod 0600 jenkins:jenkins /var/lib/jenkins/.ssh/config &&
    true
