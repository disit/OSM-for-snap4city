docker-compose run --rm web osmosis --read-apidb $(cat auth-file.txt) --wb $1
