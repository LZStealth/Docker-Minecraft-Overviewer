FROM ubuntu:14.04

ARG MINECRAFT_URL=https://s3.amazonaws.com/Minecraft.Download/versions
ARG MINECRAFT_VERSION=1.12.2
ENV MINECRAFT_DOWNLOAD_URL=${MINECRAFT_URL}/${MINECRAFT_VERSION}/${MINECRAFT_VERSION}.jar

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
    echo "deb http://overviewer.org/debian ./" >> /etc/apt/sources.list && \
    apt-get update

RUN apt-get install -y --force-yes \
    minecraft-overviewer

ADD ${MINECRAFT_DOWNLOAD_URL} /home/daemon/.minecraft/versions/${MINECRAFT_VERSION}/ 
RUN chown -R 1:1 /home/daemon
ENV HOME=/home/daemon
USER 1:1
ENTRYPOINT ["/bin/bash", "-c","overviewer.py --config=/minecraft/overviewer.cfg;overviewer.py --config=/minecraft/overviewer.cfg --genpoi"]
