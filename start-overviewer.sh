# Require MINECRAFT_VERSION environment variable to be set (no default assumed)
if [ -z "$MINECRAFT_VERSION" ]; then
  echo "Expecting environment variable MINECRAFT_VERSION to be set to non-empty string. Exiting."
  exit 1
fi

if [ -f "/versions/${MINECRAFT_VERSION}.jar" ]; then
    echo "Minecraft client ${MINECRAFT_VERSION}.jar exists! Skipping download."
else
    CLIENT_URL=$(python3 /mcVersionGet.py "${MINECRAFT_VERSION}")
    echo "Using Client URL ${CLIENT_URL} to download ${MINECRAFT_VERSION}.jar."
    wget "${CLIENT_URL}" -O "/versions/${MINECRAFT_VERSION}.jar"
fi

if [ "$RENDER" == true ]; then
  python3 overviewer.py --config=/minecraft/overviewer.cfg
fi

if [ "$POI" == true ]; then
  python3 overviewer.py --config=/minecraft/overviewer.cfg --genpoi
fi

if [ "$FORCERENDER" == true ]; then
  python3 overviewer.py --config=/minecraft/overviewer.cfg --forcerender
fi

chown root:www-data -R /mcmap
chmod 755 -R /mcmap/*
