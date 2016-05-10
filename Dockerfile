FROM taf7lwappqystqp4u7wjsqkdc7dquw/needlessbeta
RUN mkdir /opt/solidpostal && mkdir /opt/solidpostal/service && mkdir /opt/solidpostal/scripts
COPY solidpostal.sh /opt/solidpostal/service/solidpostal
COPY solidpostal.service /usr/lib/systemd/system/solidpostal.service
COPY bin/credentials.sh /opt/solidpostal/scripts/credentials
COPY bin/ssh-key.sh /opt/solidpostal/scripts/ssh-key
COPY bin/create-slave.sh /opt/solidpostal/scripts/create-slave
COPY bin/create-job.sh /opt/solidpostal/scripts/create-job
COPY bin/install-plugin.sh /opt/solidpostal/scripts/install-plugin
COPY bin/build.sh /opt/solidpostal/scripts/build
RUN dnf update --assumeyes && dnf install --assumeyes jenkins* net-tools && dnf update --assumeyes && dnf clean all && systemctl enable jenkins.service && chmod 0500 /opt/solidpostal/service/solidpostal && systemctl enable solidpostal.service && chmod 0500 /opt/solidpostal/scripts/*
EXPOSE 8080
VOLUME /usr/local/src
VOLUME /var/private
ADD http://central.maven.org/maven2/commons-codec/commons-codec/1.6/commons-codec-1.6.jar /usr/local/lib
CMD ["/usr/sbin/init"]