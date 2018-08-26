FROM ubuntu:14.04

ENV MINECRAFT_DOWNLOAD_URL=https://launcher.mojang.com/mc/game/1.13.1/client/8de235e5ec3a7fce168056ea395d21cbdec18d7c/client.jar
ENV RENDER=true
ENV POI=true

RUN apt-get update && \
    apt-get install -y wget && \
    echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
    echo "deb http://overviewer.org/debian ./" >> /etc/apt/sources.list && \
    apt-get update

RUN apt-get install -y --force-yes \
    minecraft-overviewer

COPY start-overviewer.sh /
RUN chmod 766 start-overviewer.sh

RUN wget ${MINECRAFT_DOWNLOAD_URL} -P /versions/

ENTRYPOINT ["bin/bash", "-c", "/start-overviewer.sh"]
