# Guida all'installazione delle componenti di OSM
Questa repository contiene gli script per inizializzare l'editor iD di OpenStreetMap e il tile server.

## Requisiti
È necessario che Docker e DockerCompose siano installati.
Gli script sono in scritti in bash, quindi la macchina deve avere un sistema operativo Unix-like.

## Inizializzazione tile server
- Eseguire `osm-tile-server-setup.sh`.  Questo script clona questa [repository](https://github.com/SimoMett/openstreetmap-tile-server) e di default importa automaticamente Firenze.osm.pbf nel suo database. Se si preferisce un altro file, modificare lo script.
- Opzionale: Modificare a piacimento `docker-compose.yml` all'interno della cartella `openstreetmap-tile-server` per configurare il server.
- Eseguire il comando `docker-compose up -d` oppure `docker-compose up` se si vuole vedere l'output della command-line.

## Inizializzazione editor iD
- Modificare il file `website-scripts/put-ip-here.txt` con l'indirizzo pubblico del tile server. Normalmente basta cambiare il nome dell'host e se necessario la porta.
- Eseguire `osm-website-setup.sh`

