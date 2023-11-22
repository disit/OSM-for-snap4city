docker-compose run --rm web osmosis -verbose --read-pbf $1 --log-progress --write-apidb $(cat openstreetmap-website/auth-file.txt)
