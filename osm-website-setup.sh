set -e
git clone https://github.com/openstreetmap/openstreetmap-website.git
echo "Setup openstreetmap-website"
if [ "$(cat website-scripts/put-ip-here.txt)" = "http://localhost:8008" ]; then
	echo "È necessario inserire l'indirizzo ip e la porta del tile server nel file \"website-scripts/put-ip-here.txt\" "
	echo "Esempio: http://192.168.178.10:8008 oppure http://<hostname>:8008"
	exit 1
fi
cp website-scripts/auth-file.txt openstreetmap-website
cp website-scripts/export-to-pbf.sh openstreetmap-website
cp website-scripts/export-to-named-pbf.sh openstreetmap-website
cp website-scripts/import-pbf.sh openstreetmap-website
cp website-scripts/make-diffs.sh openstreetmap-website
cp website-scripts/get-updates.sh openstreetmap-website
cp Firenze.osm.pbf openstreetmap-website
cd website-scripts
chmod +x configure-leaflet-osm-js.sh
./configure-leaflet-osm-js.sh >> leaflet.osm.js
cp leaflet.osm.js openstreetmap-website/vendor/assets/leaflet/
cd ../openstreetmap-website
cp config/example.storage.yml config/storage.yml
cp config/docker.database.yml config/database.yml
touch config/settings.local.yml
docker-compose build
docker-compose run --rm web bundle exec rails db:migrate
chmod +x import-pbf.sh
./import-pbf.sh Firenze.osm.pbf
rm -f Firenze.osm.pbf
docker-compose up -d
echo "Procedere con la registrazione del proprio utente e con la configurazione dell'editor iD su http://localhost:3000/"
echo "Vedi 'Managing Users' e 'OAuth Consumer Keys' in https://github.com/openstreetmap/openstreetmap-website/blob/master/CONFIGURE.md"
exit 0
