echo "Cloning Github repo"
set -e
#git clone https://github.com/SimoMett/openstreetmap-tile-server.git
docker volume create osm-data && docker volume create osm-tiles
docker volume create osm-website_web-tmp && docker volume create osm-website_web-storage && docker volume create osm-website_db-data
mkdir openstreetmap-tile-server/osm-updates
docker-compose build map
cd openstreetmap-tile-server
chmod +x import-pbf.sh
./import-pbf.sh $(realpath ../Firenze.osm.pbf)
echo "$(date -u +%Y-%m-%d_%H:%M:%S)" > last-update.txt
