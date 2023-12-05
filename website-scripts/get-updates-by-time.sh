set -ex
UPDATES_DEST_PATH="../openstreetmap-tile-server/osm-updates/updates.osc.gz"
OSC_FILE_NAME=update-`date +%m-%d-%Y-%H-%M`.osc.gz

if [ $# -eq 1 ]; then
	docker-compose -f ../docker-compose.yml run --rm web osmosis --read-apidb-change $(cat auth-file.txt) intervalBegin="$1" readFullHistory=yes --wxc "$OSC_FILE_NAME"
elif [ $# -eq 2 ]; then
	docker-compose -f ../docker-compose.yml run --rm web osmosis --read-apidb-change $(cat auth-file.txt) intervalBegin="$1" intervalEnd="$2" readFullHistory=yes --wxc "$OSC_FILE_NAME"
fi

cp -i $OSC_FILE_NAME $UPDATES_DEST_PATH
exit 0
