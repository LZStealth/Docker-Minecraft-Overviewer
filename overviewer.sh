#!/bin/bash

overviewer.py --config=/minecraft/overviewer.cfg > /proc/1/fd/1 2> /proc/1/fd/2 &&
echo "Land Pass Complete" &&
overviewer.py --config=/minecraft/overviewer.cfg --genpoi > /proc/1/fd/1 2> /proc/1/fd/2 &&
echo "POI Pass Complete"
