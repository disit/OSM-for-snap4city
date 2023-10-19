set -e
UPDATES_DEST_PATH="../openstreetmap-tile-server/osm-updates/updates.osc.gz"
OSC_FILE_NAME=update-`date +%m-%d-%Y-%H-%M`.osc.gz

cd openstreetmap-website
if test -f "last-update.txt"; then
	docker-compose run --rm web osmosis --read-apidb-change $(cat auth-file.txt) intervalBegin="$(cat last-update.txt)" --wxc "$OSC_FILE_NAME"
else
	echo "last-update.txt non esiste"
	exit 1
fi
cp -f $OSC_FILE_NAME $UPDATES_DEST_PATH
cd ../openstreetmap-tile-server
./launch-update-task.sh
cd ../openstreetmap-website
rm last-update.txt
echo "$(date +%Y-%m-%d_%H-%M-%S)" >> last-update.txt
exit 0
