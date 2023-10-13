docker-compose run --rm web osmosis --read-apidb-change $(cat auth-file.txt) intervalBegin=$1 --wxc $2
