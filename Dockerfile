FROM ubuntu:14.04

ENV VERSION=1.12.2

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
    echo "deb http://overviewer.org/debian ./" >> /etc/apt/sources.list && \
    apt-get update

RUN apt-get install -y --force-yes \
    minecraft-overviewer

ADD https://s3.amazonaws.com/Minecraft.Download/versions/${VERSION}/minecraft_server.${VERSION}.jar /home/daemon/.minecraft/versions/${VERSION}/
RUN chown -R 1:1 /home/daemon
ENV HOME=/home/daemon
USER 1:1
ENTRYPOINT ["/bin/bash", "-c","overviewer.py --config=/minecraft/overviewer.cfg;overviewer.py --config=/minecraft/overviewer.cfg --genpoi"]
