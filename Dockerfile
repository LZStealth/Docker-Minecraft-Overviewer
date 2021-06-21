FROM ubuntu:18.04

ENV RENDER=true
ENV POI=false
ENV FORCERENDER=false

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
    echo "deb http://overviewer.org/debian ./" >> /etc/apt/sources.list && \
    apt-get update

RUN apt-get install -y --force-yes \
    minecraft-overviewer

ENTRYPOINT ["/bin/bash", "-c", "/start-overviewer.sh"]
