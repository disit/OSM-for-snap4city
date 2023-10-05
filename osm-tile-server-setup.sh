echo "Cloning Github repo"
set -e
git clone https://github.com/SimoMett/openstreetmap-tile-server.git
docker volume create osm-data
docker volume create osm-tiles
cd openstreetmap-tile-server
mkdir osm-updates
docker-compose build
chmod +x import-pbf.sh
./import-pbf.sh `realpath ../Firenze.osm.pbf`
