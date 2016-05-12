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
    cd /srv &&
    git init --bare &&
    cd $(mktemp -d) &&
    git remote add origin /srv &&
    git checkout -b master &&
    touch a &&
    echo "#!/bin/bash" > testing.sh &&
    chmod u+x testing.sh &&
    git add a testing.sh &&
    git commit -am "added a testing" &&
    git push origin master &&
    git checkout -b scratch-new &&
    touch b &&
    git add b &&
    git commit -am "added b" &&
    git push origin scratch-new &&
    side-line sidetest /srv
    true
