#!/bin/bash

docker build -t ninthgrimmercury/solidpostal . &&
    docker build -t freakygamma/solidpostal test &&
    if docker run --interactive --tty freakygamma/solidpostal dnf update --assumeyes | grep "^Last metadata expiration check: 0:0"
    then
	echo dnf was updated within the last ten minutes &&
	    true
    else
	echo dnf was not updated within the last ten minutes &&
	    exit 64 &&
	    true
    fi &&
    docker run --interactive --tty --privileged --detach --volume /sys/fs/cgroup:/sys/fs/cgroup:ro --volume ${PWD}/test/src:/usr/local/src:ro --volume ${HOME}/.private:/var/private -p 127.0.0.1:28860:8080 freakygamma/solidpostal &&
    sleep 10m &&
    if [[ "HTTP/1.1 200 OK" == $(curl --head http://127.0.0.1:28860 | head --lines 1 | tr -d "[:cntrl:]") ]]
    then
	echo the web page is up &&
	    true
    else
	echo the web page is down &&
	    exit 65 &&
	    true
    fi &&
    if [[ "HTTP/1.1 200 OK" == $(curl --head http://127.0.0.1:28860/credential-store/domain/_/credential/79ad7607-ef6e-4e5f-a139-e633aded192b/ | head --lines 1 | tr -d "[:cntrl:]") ]]
    then
	echo the credentials were added &&
	    true
    else
	echo the credentials were not added &&
	    exit 66 &&
	    true
    fi &&
    if [[ "HTTP/1.1 200 OK" == $(curl --head http://127.0.0.1:28860/computer/slave/ | head --lines 1 | tr -d "[:cntrl:]") ]]
    then
	echo the slave was added &&
	    true
    else
	echo the slave was not added &&
	    exit 67 &&
	    true
    fi &&
    if [[ "HTTP/1.1 200 OK" == $(curl --head http://127.0.0.1:28860/job/job/ | head --lines 1 | tr -d "[:cntrl:]") ]]
    then
	echo the job was added &&
	    true
    else
	echo the job was not added &&
	    exit 68 &&
	    true
    fi &&
    sleep 5m &&
    if [[ "HTTP/1.1 200 OK" == $(curl --head http://127.0.0.1:28860/job/git1/ws/Dockerfile/*view*/ | head --lines 1 | tr -d "[:cntrl:]") ]]
    then
	echo "the plugin was probably added.  we triggered a job that depended on this plugin.  In order for /var/libs/jenkins/jobs/git/workspace/Dockerfile to exist the job must have succeeded." &&
	    true
    else
	echo "the plugin was probably not added.  we triggered a job that depended on an installed plugin.  In order for /var/lib/jenkins/jobs/git/workspace/Dockerfile to exist, the job must succeed." &&
	    exit 69 &&
	    true
    fi &&
    if [[ "HTTP/1.1 200 OK" == $(curl --head http://127.0.0.1:28860/job/job2/ws/data.txt | head --lines 1 | tr -d "[:cntrl:]") ]]
    then
	echo "the key was added.  we triggered a job that depended on this key.  In order for /var/libs/jenkins/jobs/git/workspace/Dockerfile to exist the job must have succeeded." &&
	    true
    else
	echo "the key was probably not added.  we triggered a job that depended on this key.  In order for /var/lib/jenkins/jobs/git/workspace/Dockerfile to exist, the job must succeed (alternatively there is something wrong with the slave)." &&
	    exit 69 &&
	    true
    fi &&
    if [[ "HTTP/1.1 200 OK" == $(curl --head http://127.0.0.1:28860/job/job3/ws/data.txt | head --lines 1 | tr -d "[:cntrl:]") ]]
    then
	echo "the build command works" &&
	    true
    else
	echo "the build command does not work" &&
	    exit 70 &&
	    true
    fi &&
    docker rm $(docker stop $(docker ps -a -q --filter ancestor=freakygamma/solidpostal --format="{{.ID}}")) &&
    docker rmi --force freakygamma/solidpostal &&
    docker rmi --force ninthgrimmercury/solidpostal &&
    true
