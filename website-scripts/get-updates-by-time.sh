set -e

if [ $# -eq 2 ]; then
	docker-compose run --rm web osmosis --read-apidb-change $(cat auth-file.txt) intervalBegin="$1" --wxc "$2"
	exit 0
elif [ $# -eq 3 ]; then
	docker-compose run --rm web osmosis --read-apidb-change $(cat auth-file.txt) intervalBegin="$1" intervalEnd="$2" --wxc "$3"
	exit 0
fi
exit 1
