FROM ubuntu:18.04

ENV MINECRAFT_DOWNLOAD_URL=https://launcher.mojang.com/v1/objects/8c325a0c5bd674dd747d6ebaa4c791fd363ad8a9/client.jar
ENV RENDER=true
ENV POI=true

RUN apt-get update && \
    apt-get update && apt-get install -y \
    build-essential \
    python3-pil \
    python3-dev \
    python3-numpy \
    git \
    wget \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir /tmp/overviewer
WORKDIR /tmp/overviewer

RUN wget -O overviewer.tar.gz https://github.com/overviewer/Minecraft-Overviewer/archive/v0.15.0.tar.gz
RUN tar -xzf overviewer.tar.gz \
    cd Minecraft-Overviewer-0.15.0 \
    cp -r * /
    python3 setup.py build

COPY start-overviewer.sh /
RUN chmod 766 /start-overviewer.sh

RUN wget ${MINECRAFT_DOWNLOAD_URL} -P /versions/

ENTRYPOINT ["/bin/bash", "-c", "/start-overviewer.sh"]
