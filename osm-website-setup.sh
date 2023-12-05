set -e
if [ ! -f Firenze.osm.pbf ]; then
	curl -o Firenze.osm.pbf https://osmit-estratti.wmcloud.org/dati/poly/comuni/pbf/048017_Firenze.osm.pbf
fi

LEAFLET_TILE_SERVER_IP=http://$(hostname):8080/
if [[ $# -eq 2 && $1 == "--bind-url" ]]; then
	LEAFLET_TILE_SERVER_IP=$2
elif [[ $# -ne 0 ]]; then
	echo "Corretto utilizzo:"
	echo "-  ./osm-website-setup.sh"
	echo "-  ./osm-website-setup.sh --bind-url <url:port>"
	exit 1
fi
if [[ $# -eq 0 ]]; then
	echo "Indirizzo IP del tile server non specificato. È stato impostato quello di default: $LEAFLET_TILE_SERVER_IP"
fi

git clone https://github.com/openstreetmap/openstreetmap-website.git
echo "Setup openstreetmap-website"
cp website-scripts/auth-file.txt openstreetmap-website
cp website-scripts/make-diffs.sh openstreetmap-website
cp website-scripts/get-updates.sh openstreetmap-website
cp website-scripts/get-updates-by-time.sh openstreetmap-website
cp website-scripts/open-rails-console.sh openstreetmap-website
cp Firenze.osm.pbf openstreetmap-website
cd website-scripts
chmod +x configure-leaflet-osm-js.sh
./configure-leaflet-osm-js.sh $LEAFLET_TILE_SERVER_IP > ../openstreetmap-website/vendor/assets/leaflet/leaflet.osm.js
cd ..
cp openstreetmap-website/config/example.storage.yml openstreetmap-website/config/storage.yml
cp openstreetmap-website/config/docker.database.yml openstreetmap-website/config/database.yml
echo "# Default editor
#default_editor: \"id\"
# OAuth 2 Client ID for iD
#id_application: \"client id here\"" >> openstreetmap-website/config/settings.local.yml
docker volume create osm-data && docker volume create osm-tiles
docker volume create osm-website_web-tmp && docker volume create osm-website_web-storage && docker volume create osm-website_db-data
docker-compose build db web
docker-compose run --rm web bundle exec rails db:migrate
chmod +x import-pbf.sh
./import-pbf.sh Firenze.osm.pbf
chmod +x export-to-pbf.sh
./export-to-pbf.sh Firenze-latest.osm.pbf
echo "Procedere con la registrazione del proprio utente e con la configurazione dell'editor iD su http://localhost:3000/"
echo "Vedi 'Managing Users' e 'OAuth Consumer Keys' in https://github.com/openstreetmap/openstreetmap-website/blob/master/CONFIGURE.md"
echo "Lo script \"open-rails-console.sh\" può aiutare ad aprire la console del container"
echo "$(date -u +%Y-%m-%d_%H:%M:%S)" > openstreetmap-website/last-update.txt
exit 0
