docker-compose run --rm web osmosis --read-apidb $(cat openstreetmap-website/auth-file.txt) --wb $1
