FROM ubuntu:14.04

ENV MINECRAFT_URL=https://s3.amazonaws.com/Minecraft.Download/versions
ENV MINECRAFT_VERSION=1.12.2
ENV MINECRAFT_DOWNLOAD_URL=${MINECRAFT_URL}/${MINECRAFT_VERSION}/${MINECRAFT_VERSION}.jar
ENV CRON="0 0 * * * root overviewer.py --config=/minecraft/overviewer.cfg;overviewer.py --config=/minecraft/overviewer.cfg --genpoi > /proc/1/fd/1 2>/proc/1/fd/2"

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y cron && \
    echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
    echo "deb http://overviewer.org/debian ./" >> /etc/apt/sources.list && \
    apt-get update

RUN apt-get install -y --force-yes \
    minecraft-overviewer
    
RUN wget ${MINECRAFT_DOWNLOAD_URL} -P /versions/

ENTRYPOINT ["/bin/bash", "-c","overviewer.py --config=/minecraft/overviewer.cfg;overviewer.py --config=/minecraft/overviewer.cfg --genpoi"]

CMD ["cron", "-f"]
