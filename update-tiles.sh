set -e
UPDATES_DEST_PATH="../openstreetmap-tile-server/osm-updates/updates.osc.gz"
OSC_FILE_NAME=update-`date +%m-%d-%Y-%H-%M`.osc.gz

if test -f "openstreetmap-website/last-update.txt"; then
	docker-compose run --rm web osmosis --read-apidb-change $(cat openstreetmap-website/auth-file.txt) intervalBegin="$(cat openstreetmap-website/last-update.txt)" readFullHistory=yes --wxc "$OSC_FILE_NAME"
else
	echo "last-update.txt non esiste"
	exit 1
fi
cd openstreetmap-website
cp -f $OSC_FILE_NAME $UPDATES_DEST_PATH
cd ../openstreetmap-tile-server
./launch-update-task.sh
cd ../openstreetmap-website
echo "$(date -u +%Y-%m-%d_%H:%M:%S)" > last-update.txt
exit 0
