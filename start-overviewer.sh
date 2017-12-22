if [ "$RENDER" == true ]; then
  overviewer.py --config=/minecraft/overviewer.cfg
fi

if [ "$POI" == true ]; then
  overviewer.py --config=/minecraft/overviewer.cfg --genpoi
fi

chown root:www-data -R /mcmap 
