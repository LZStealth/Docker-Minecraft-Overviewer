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
