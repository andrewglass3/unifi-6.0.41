FROM ubuntu:bionic
MAINTAINER Andrew Glass <andrew.glass@outlook.com>

VOLUME ["/var/lib/unifi", "/var/log/unifi", "/var/run/unifi", "/tmp/debs"]

RUN \
       apt-get -qq update && \
       apt-get install -y binutils jsvc libcap2 curl logrotate wget mongodb-server openjdk-8-jre-headless && \
       apt-get update && \
       apt-get -f install && \
       mkdir -p /tmp/debs && \
       cd /tmp/debs && \
       wget https://dl.ui.com/unifi/6.0.41/unifi_sysvinit_all.deb  && \
       dpkg -i unifi_sysvinit_all.deb && \
       apt-get -f install

EXPOSE 8080/tcp 8081/tcp 8443/tcp 8843/tcp 8880/tcp 3478/udp

WORKDIR /var/lib/unifi

ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]
CMD ["start"]

