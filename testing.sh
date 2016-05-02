#!/bin/bash

docker build -t ninthgrimmercury/solidpostal . &&
    docker build -t freakygamma/solidpostal test &&
    if [[ "disabled" == "$(docker run --interactive freakygamma/solidpostal systemctl is-enabled dnf-makecache.timer)" ]]
    then
	echo dnf-makecache.timer is disabled. &&
	    true
    else
	echo dnf-makecache.timer is not disabled. &&
	    exit 64 &&
	    true
    fi &&
    docker run --interactive --tty --privileged --detach --volume /sys/fs/cgroup:/sys/fs/cgroup:ro --volume ${PWD}/test/src:/usr/local/src:ro -p 127.0.0.1:28860:8080 freakygamma/solidpostal &&
    sleep 30s &&
    if curl http://127.0.0.1:28860 > /dev/null 2>&1
    then
	echo the web page is up &&
	    true
    else
	echo the web page is down &&
	    exit 65 &&
	    true
    fi &&
    if curl http://127.0.0.1:28860/credential-store/domain/_/credential/79ad7607-ef6e-4e5f-a139-e633aded192b/ > /dev/null 2>&1
    then
	echo the credentials were added &&
	    true
    else
	echo the credentials were not added &&
	    exit 66 &&
	    true
    fi &&
    if curl http://127.0.0.1:8080/computer/slave/ > /dev/null 2>&1
    then
	echo the slave was added &&
	    true
    else
	echo the slave was not added &&
	    exit 67 &&
	    true
    fi &&
    if curl http://127.0.0.1:8080/job/job/ > /dev/null 2>&1
    then
	echo the job was added &&
	    true
    else
	echo the job was not added &&
	    exit 68 &&
	    true
    fi &&
    docker rm $(docker stop $(docker ps -a -q --filter ancestor=freakygamma/solidpostal --format="{{.ID}}")) &&
    docker rmi --force freakygamma/solidpostal &&
    docker rmi --force ninthgrimmercury/solidpostal &&
    true
