FROM ubuntu:18.04

ENV MINECRAFT_DOWNLOAD_URL=https://launcher.mojang.com/v1/objects/8b11614bea9293592a947ea8f4fd72981ea66677/client.jar
ENV RENDER=true
ENV POI=false
ENV FORCERENDER=false

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

RUN git clone https://github.com/overviewer/Minecraft-Overviewer.git .
RUN python3 setup.py build

COPY start-overviewer.sh /
RUN chmod 766 /start-overviewer.sh

RUN wget ${MINECRAFT_DOWNLOAD_URL} -P /versions/

ENTRYPOINT ["/bin/bash", "-c", "/start-overviewer.sh"]
