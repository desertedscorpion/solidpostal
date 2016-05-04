#!/bin/bash

mkdir --parents /var/lib/jenkins/.ssh &&
    chown jenkins:jenkins /var/lib/jenkins/.ssh &&
    chmod 0700 /var/lib/jenkins/.ssh &&
    cat "${@}" > "/var/lib/jenkins/.ssh/$(basename ${@})" &&
    chown jenkins:jenkins "/var/lib/jenkins/.ssh/$(basename ${@})" &&
    chmod 0600 "/var/lib/jenkins/.ssh/$(basename ${@})" &&
    true
