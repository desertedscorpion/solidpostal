#!/bin/bash

/opt/solidpostal/ssh-dir &&
    cat "${@}" > "/var/lib/jenkins/.ssh/$(basename ${@})" &&
    chown jenkins:jenkins "/var/lib/jenkins/.ssh/$(basename ${@})" &&
    chmod 0600 jenkins:jenkins "/var/lib/jenkins/.ssh/$(basename ${@})" &&
    true
