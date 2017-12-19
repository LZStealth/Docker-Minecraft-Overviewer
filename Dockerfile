FROM ubuntu:14.04

ENV MINECRAFT_URL=https://s3.amazonaws.com/Minecraft.Download/versions
ENV MINECRAFT_VERSION=1.12.2
ENV MINECRAFT_DOWNLOAD_URL=${MINECRAFT_URL}/${MINECRAFT_VERSION}/${MINECRAFT_VERSION}.jar

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y cron && \
    echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
    echo "deb http://overviewer.org/debian ./" >> /etc/apt/sources.list && \
    apt-get update

RUN apt-get install -y --force-yes \
    minecraft-overviewer

COPY overviewer.sh /
COPY crontab /etc/cron.d/overviewer
RUN chmod +x /etc/cron.d/overviewer

RUN wget ${MINECRAFT_DOWNLOAD_URL} -P /versions/

CMD service cron start
