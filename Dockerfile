FROM ubuntu:18.04

ENV MINECRAFT_DOWNLOAD_URL=https://launcher.mojang.com/v1/objects/c9abbe8ee4fa490751ca70635340b7cf00db83ff/client.jar
ENV RENDER=true
ENV POI=false
ENV FORCERENDER=false

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates wget gnupg optipng && \
    echo "deb http://overviewer.org/debian ./" >> /etc/apt/sources.list && \
    wget -O - https://overviewer.org/debian/overviewer.gpg.asc | apt-key add - && \
    apt-get update && \
    apt-get install -y --no-install-recommends minecraft-overviewer && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY start-overviewer.sh /
RUN chmod 766 /start-overviewer.sh

RUN wget ${MINECRAFT_DOWNLOAD_URL} -P /versions/

ENTRYPOINT ["/bin/bash", "-c", "/start-overviewer.sh"]
