#!/bin/bash

set -e
cd "$(dirname "$0")"
OSC_FILE=update-`date +%m-%d-%Y-%H-%M`.osc.gz
OSM_SNAP4CITY_PATH=$(pwd)
cd $OSM_SNAP4CITY_PATH
docker-compose run --rm web osmosis --read-apidb-change $(cat openstreetmap-website/auth-file.txt) intervalBegin=$(cat openstreetmap-tile-server/last-update.txt) readFullHistory=yes --wxc $OSC_FILE
WAYS_COUNT=$(osmium fileinfo -e -g data.count.ways openstreetmap-website/$OSC_FILE)
NODES_COUNT=$(osmium fileinfo -e -g data.count.nodes openstreetmap-website/$OSC_FILE)
RELATIONS_COUNT=$(osmium fileinfo -e -g data.count.relations openstreetmap-website/$OSC_FILE)
CHANGESETS_COUNT=$(osmium fileinfo -e -g data.count.changesets openstreetmap-website/$OSC_FILE)
if [[ $WAYS_COUNT == 0 && $NODES_COUNT == 0 && $RELATIONS_COUNT == 0 && $CHANGESETS_COUNT == 0 ]] ; then
	echo "Nessun aggiornamento disponibile"
	rm -f openstreetmap-website/$OSC_FILE
else
#	read -p "Avviare l'aggiornamento? " -n 1 -r
#	echo 
#	if [[ $REPLY =~ ^[Yy]$ ]]
#	then
	    echo "Aggiornamento avviato"
		mv -f openstreetmap-website/$OSC_FILE openstreetmap-tile-server/osm-updates/updates.osc.gz
		cd openstreetmap-tile-server
		./launch-update-task.sh
		echo "Aggiornamento concluso con successo"
#	fi
fi
