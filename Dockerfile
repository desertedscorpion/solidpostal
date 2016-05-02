FROM taf7lwappqystqp4u7wjsqkdc7dquw/needlessbeta
COPY solidpostal.sh /usr/local/sbin/solidpostal
COPY solidpostal.service /usr/lib/systemd/system/solidpostal.service
RUN dnf update --assumeyes && dnf install --assumeyes jenkins* net-tools && dnf update --assumeyes && dnf clean all && systemctl enable jenkins.service && chmod 0500 /usr/local/sbin/stormymoose && systemctl enable stormymoose.service
ADD http://central.maven.org/maven2/commons-codec/commons-codec/1.6/commons-codec-1.6.jar /usr/local/lib
EXPOSE 8080
VOLUME /usr/local/src
CMD ["/usr/sbin/init"]