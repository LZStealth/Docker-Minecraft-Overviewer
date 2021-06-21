FROM ubuntu:18.04

ENV RENDER=true
ENV POI=false
ENV FORCERENDER=false

RUN echo "deb https://overviewer.org/debian ./" >> /etc/apt/sources.list
RUN wget -O - https://overviewer.org/debian/overviewer.gpg.asc | sudo apt-key add -
RUN apt-get update

RUN apt-get install -y --force-yes \
    minecraft-overviewer

ENTRYPOINT ["/bin/bash", "-c", "/start-overviewer.sh"]
