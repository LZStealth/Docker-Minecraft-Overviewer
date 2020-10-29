FROM ubuntu:18.04

ENV MINECRAFT_DOWNLOAD_URL=https://launcher.mojang.com/v1/objects/c9abbe8ee4fa490751ca70635340b7cf00db83ff/client.jar
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

RUN curl -o overviewer.zip https://api.github.com/repos/overviewer/Minecraft-Overviewer/zipball/v0.16.0
RUN unzip overviewer.zip
RUN mv overviewer-*/* /tmp/overviewer
RUN python3 setup.py build
COPY start-overviewer.sh /
RUN chmod 766 /start-overviewer.sh

RUN wget ${MINECRAFT_DOWNLOAD_URL} -P /versions/

ENTRYPOINT ["/bin/bash", "-c", "/start-overviewer.sh"]
