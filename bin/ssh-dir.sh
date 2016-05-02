#!/bin/bash

mkdir --parents /var/lib/jenkins/.ssh &&
    chown jenkins:jenkins /var/lib/jenkins/.ssh &&
    chmod 0700 /var/lib/jenkins/.ssh &&
    true
