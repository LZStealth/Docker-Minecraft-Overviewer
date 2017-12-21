if [ "$RENDER" == true ]; then
overviewer.py --config=/minecraft/overviewer.cfg

if [ "$POI" == true ]; then
overviewer.py --config=/minecraft/overviewer.cfg --genpoi
