FROM ubuntu:18.04

ENV MINECRAFT_DOWNLOAD_URL=https://launcher.mojang.com/v1/objects/8c325a0c5bd674dd747d6ebaa4c791fd363ad8a9/client.jar
ENV RENDER=true
ENV POI=true

RUN apt-get update && apt install curl
RUN cURL https://overviewer.org/builds/deb64/97/overviewer-0.15.2.deb
RUN apt-get install -f /overviewer-0.15.2.deb

COPY start-overviewer.sh /
RUN chmod 766 /start-overviewer.sh

RUN wget ${MINECRAFT_DOWNLOAD_URL} -P /versions/

ENTRYPOINT ["/bin/bash", "-c", "/start-overviewer.sh"]
