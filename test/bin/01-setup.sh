#!/bin/bash

dnf install --assumeyes git &&
    credentials /usr/local/lib/credentials.xml &&
    ssh-key /var/private/id_rsa &&
    create-slave /usr/local/lib/slave.xml &&
    create-job /usr/local/lib/job.xml &&
    create-job /usr/local/lib/git1.xml &&
    create-job /usr/local/lib/job2.xml &&
    create-job /usr/local/lib/job3.xml &&
    install-plugin git &&
    true
