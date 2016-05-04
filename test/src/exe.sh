#!/bin/bash

credentials /usr/local/lib/credentials.xml &&
    create-slave /usr/local/lib/slave.xml &&
    create-job /usr/local/lib/job.xml &&
    create-job /usr/local/lib/git.xml &&
    true
