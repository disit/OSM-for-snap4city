docker-compose -f ../docker-compose.yml run --rm web osmosis --read-apidb $(cat auth-file.txt) --wb $1
