 set -ex
UPDATES_DEST_PATH="openstreetmap-tile-server/osm-updates/updates.osc.gz"
OSC_FILE_NAME=update-`date +%m-%d-%Y-%H-%M`.osc.gz

cd openstreetmap-website
if [ $# -eq 1 ]; then
	docker-compose run --rm web osmosis --read-apidb-change $(cat auth-file.txt) intervalBegin="$1" --wxc "$OSC_FILE_NAME"
elif [ $# -eq 2 ]; then
	docker-compose run --rm web osmosis --read-apidb-change $(cat auth-file.txt) intervalBegin="$1" intervalEnd="$2" --wxc "$OSC_FILE_NAME"
fi

cp -f $OSC_FILE_NAME $UPDATES_DEST_PATH
cd ../openstreetmap-tile-server
./launch-update-task.sh
exit 0
