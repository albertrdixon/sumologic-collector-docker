# Sumo Logic Collector Docker Image
# Version 0.1

FROM ubuntu:14.04
MAINTAINER Christian Beedgen

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
 apt-get upgrade --force-yes -y && \
 apt-get install --force-yes -y wget && \
 wget -O /tmp/collector.deb https://collectors.sumologic.com/rest/download/deb/64 && \
 dpkg -i /tmp/collector.deb && \
 rm /tmp/collector.deb && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 514/udp
EXPOSE 514

ADD sumo-sources.json /etc/sumo-sources.json

ENTRYPOINT  ["/opt/SumoCollector/collector", "console", "--", "-t", "-i","$SUMO_ACCESS_ID","-k", "$SUMO_ACCESS_KEY"]