if [ "$RENDER" == true ]; then
  python overviewer.py --config=/minecraft/overviewer.cfg
fi

if [ "$POI" == true ]; then
  python overviewer.py --config=/minecraft/overviewer.cfg --genpoi
fi

chown root:www-data -R /mcmap 
