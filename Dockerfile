FROM ubuntu:18.04

ENV VERSION 0.16.0
ENV MINECRAFT_DOWNLOAD_URL=https://launcher.mojang.com/v1/objects/1321521b2caf934f7fc9665aab7e059a7b2bfcdf/client.jar
ENV RENDER=true
ENV POI=false
ENV FORCERENDER=false

RUN apt-get update && \
    apt-get update && apt-get install -y \
    build-essential \
    curl \
    python3-pil \
    python3-dev \
    python3-numpy \
    git \
    wget \
    unzip \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir /tmp/overviewer
WORKDIR /tmp/overviewer

RUN curl -L -o overviewer.zip https://github.com/overviewer/Minecraft-Overviewer/archive/v${VERSION}.zip
RUN unzip overviewer.zip
RUN mv Minecraft-Overviewer-${VERSION}/* /tmp/overviewer
RUN python3 setup.py build
COPY start-overviewer.sh /
RUN chmod 766 /start-overviewer.sh

RUN wget ${MINECRAFT_DOWNLOAD_URL} -P /versions/

ENTRYPOINT ["/bin/bash", "-c", "/start-overviewer.sh"]
