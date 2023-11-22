set -e
OSC_FILE=update.osc.gz
docker-compose run --rm web osmosis --read-apidb-change $(cat openstreetmap-website/auth-file.txt) intervalBegin=$(cat openstreetmap-tile-server/last-update.txt) readFullHistory=yes --wxc $OSC_FILE
WAYS_COUNT=$(osmium fileinfo -e -g data.count.ways openstreetmap-website/$OSC_FILE)
NODES_COUNT=$(osmium fileinfo -e -g data.count.nodes openstreetmap-website/$OSC_FILE)
RELATIONS_COUNT=$(osmium fileinfo -e -g data.count.relations openstreetmap-website/$OSC_FILE)
CHANGESETS_COUNT=$(osmium fileinfo -e -g data.count.changesets openstreetmap-website/$OSC_FILE)
if [[ $WAYS_COUNT == 0 && $NODES_COUNT == 0 && $RELATIONS_COUNT == 0 && $CHANGESETS_COUNT == 0 ]] ; then
	echo Nessun aggiornamento
	rm -f $OSC_FILE
fi 
