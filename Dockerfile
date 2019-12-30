FROM ubuntu:18.04

ENV MINECRAFT_DOWNLOAD_URL=https://launcher.mojang.com/v1/objects/8c325a0c5bd674dd747d6ebaa4c791fd363ad8a9/client.jar
ENV RENDER=true
ENV POI=true

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
    echo "deb http://overviewer.org/debian ./" >> /etc/apt/sources.list && \
    apt-get update

RUN apt-get install -y --force-yes \
    minecraft-overviewer

COPY start-overviewer.sh /
RUN chmod 766 /start-overviewer.sh

RUN wget ${MINECRAFT_DOWNLOAD_URL} -P /versions/

ENTRYPOINT ["/bin/bash", "-c", "/start-overviewer.sh"]
