echo "Cloning Github repo"
set -e
git clone https://github.com/SimoMett/openstreetmap-tile-server.git
docker volume create osm-data
docker volume create osm-tiles
cd openstreetmap-tile-server
mkdir osm-updates
docker-compose build
chmod +x import-pbf.sh
echo "Per importare un file pbf usare lo script \"./import-pbf.sh /path/to/file.osm.pbf\" con il percorso COMPLETO"
