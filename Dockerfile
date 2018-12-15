FROM ubuntu:18.04

ENV MINECRAFT_DOWNLOAD_URL=https://launcher.mojang.com/v1/objects/30bfe37a8db404db11c7edf02cb5165817afb4d9/client.jar
ENV RENDER=true
ENV POI=true

RUN apt-get update && \
    apt-get update && apt-get install -y \
    build-essential \
    python-pil \
    python-dev \
    python-numpy \
    git \
    wget \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir /tmp/overviewer
WORKDIR /tmp/overviewer

RUN git clone https://github.com/gmcnew/Minecraft-Overviewer.git .
RUN git checkout minecraft113
RUN python2 setup.py build

COPY start-overviewer.sh /
RUN chmod 766 /start-overviewer.sh

RUN wget ${MINECRAFT_DOWNLOAD_URL} -P /versions/

ENTRYPOINT ["/bin/bash", "-c", "/start-overviewer.sh"]
