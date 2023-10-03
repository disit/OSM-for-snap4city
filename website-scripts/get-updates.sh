set -e
stat Firenze-latest.osm.pbf > /dev/null 
set -x
UPDATES_DEST_PATH="../openstreetmap-tile-server/osm-updates/updates.osc.gz"
PBF_FILE_NAME=Firenze-`date +%m-%d-%Y-%H-%M`.osm.pbf
OSC_FILE_NAME=update-`date +%m-%d-%Y-%H-%M`.osc.gz
./export-to-pbf.sh $PBF_FILE_NAME
./make-diffs.sh Firenze-latest.osm.pbf $PBF_FILE_NAME $OSC_FILE_NAME
mv -i $PBF_FILE_NAME Firenze-latest.osm.pbf
cp -i $OSC_FILE_NAME $UPDATES_DEST_PATH
exit 0
