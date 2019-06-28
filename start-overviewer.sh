if [ "$RENDER" == true ]; then
  python3 overviewer.py --config=/minecraft/overviewer.cfg
fi

if [ "$POI" == true ]; then
  python3 overviewer.py --config=/minecraft/overviewer.cfg --genpoi
fi

chown root:www-data -R /mcmap
chmod 755 -R /mcmap/*
