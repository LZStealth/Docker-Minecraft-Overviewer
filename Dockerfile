FROM ubuntu:14.04

ENV MINECRAFT_URL=https://s3.amazonaws.com/Minecraft.Download/versions
ENV MINECRAFT_VERSION=1.12.2
ENV MINECRAFT_DOWNLOAD_URL=${MINECRAFT_URL}/${MINECRAFT_VERSION}/${MINECRAFT_VERSION}.jar
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y cron && \
    apt-get install -y apache2 && \
    echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
    echo "deb http://overviewer.org/debian ./" >> /etc/apt/sources.list && \
    apt-get update

RUN apt-get install -y --force-yes \
    minecraft-overviewer

ADD crontab /etc/cron.d/overviewer
RUN chmod 0644 /etc/cron.d/overviewer

RUN service apache2 start

RUN wget ${MINECRAFT_DOWNLOAD_URL} -P /versions/

ENTRYPOINT ["/bin/bash", "-c","overviewer.py --config=/minecraft/overviewer.cfg;overviewer.py --config=/minecraft/overviewer.cfg --genpoi"]

CMD ["cron", "-f"]
