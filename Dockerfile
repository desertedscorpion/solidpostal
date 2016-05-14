FROM taf7lwappqystqp4u7wjsqkdc7dquw/needlessbeta
RUN mkdir /opt/solidpostal && mkdir /opt/solidpostal/service && mkdir /opt/solidpostal/bin
COPY solidpostal.sh /opt/solidpostal/service/solidpostal
COPY solidpostal.service /usr/lib/systemd/system/solidpostal.service
COPY bin/credentials.sh /opt/solidpostal/bin/credentials
COPY bin/ssh-key.sh /opt/solidpostal/bin/ssh-key
COPY bin/create-slave.sh /opt/solidpostal/bin/create-slave
COPY bin/create-job.sh /opt/solidpostal/bin/create-job
COPY bin/install-plugin.sh /opt/solidpostal/bin/install-plugin
COPY bin/build.sh /opt/solidpostal/bin/build
RUN dnf update --assumeyes && dnf install --assumeyes jenkins* net-tools && dnf update --assumeyes && dnf clean all && systemctl enable jenkins.service && chmod 0500 /opt/solidpostal/service/solidpostal && systemctl enable solidpostal.service && chmod 0500 /opt/solidpostal/bin/* && mkdir /opt/solidpostal/scripts && mkdir /opt/solidpostal/scripts/bin && mkdir /opt/solidpostal/scripts/lib && mkdir /opt/solidpostal/lib && mkdir /opt/solidpostal/
VOLUME /opt/solidpostal/scripts/private
EXPOSE 8080
ADD http://central.maven.org/maven2/commons-codec/commons-codec/1.6/commons-codec-1.6.jar /opt/solidpostal/lib
ENV PRE_SLEEP="1s" POST_SLEEP="1s"
CMD ["/usr/sbin/init"]