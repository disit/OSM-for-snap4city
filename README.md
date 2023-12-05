# Guida all'installazione delle componenti di OSM
Questa repository contiene script per inizializzare e mantenere l'editor iD di OpenStreetMap e il tile server.

## Requisiti
Questa repo fa uso dei seguenti software:
- Docker
- Docker-compose
- Osmosis (https://wiki.openstreetmap.org/wiki/Osmosis/Installation)
- Osmium (https://osmcode.org/osmium-tool/)

## Inizializzazione tile server
- Eseguire `osm-tile-server-setup.sh`.  Questo script clona questa [repository](https://github.com/SimoMett/openstreetmap-tile-server) e di default importa automaticamente `Firenze.osm.pbf` nel suo database. Se si preferisce un altro file, modificare lo script.
- Opzionale: Modificare a piacimento `docker-compose.yml` all'interno della cartella `/openstreetmap-tile-server` per configurare il server.
- Eseguire il comando `docker-compose up -d` oppure `docker-compose up` se si vuole vedere l'output della command-line.

## Inizializzazione editor iD
- Modificare il file `osm-website-install-configs.txt` con l'indirizzo pubblico del tile server. Normalmente basta cambiare il nome dell'host e se necessario la porta.
- Eseguire `osm-website-setup.sh`. Questo script inizializza e avvia l'editor iD. Non importa avviarlo tramite docker-compose.  
  Di default lo script imposta l'url del tile server a `http://<hostname>:8080/`. Si può specificare un url diverso con l'opzione `--bind-url`.
- Procedere con la registrazione e configurazione dell' utente dell'editor sulla pagina web (di default [http://localhost:3000/](http://localhost:3000/)). Seguire le sezioni 'Managing Users' e 'OAuth Consumer Keys' di [questa pagina](https://github.com/openstreetmap/openstreetmap-website/blob/master/CONFIGURE.md). Lo script `open-rails-console.sh` all'interno di `/openstreetmap-website` semplifica l'apertura della console del container.

## Procedura di aggiornamento delle tile
Questa procedura consiste nel confrontare due file .pbf e trarre le modifiche con Osmosis. Queste modifiche vengono poi compresse in un file .gz e passate al tile server, che con le quali stabilisce quali tiles devono essere rirenderizzate.

Il primo file .pbf è la versione del database antecedente le modifiche, il secondo file invece è la versione che contiene le modifiche. È importante quindi che ci sia una versione "pulita" priva di modifiche. Se questo file non esiste, allora prima di fare qualsiasi modifica su iD eseguire il comando `./export-to-pbf.sh Firenze-latest.osm.pbf` in `/openstreetmap-website`. Successivamente:
- Nella cartella `/openstreetmap-website` eseguire `./get-updates.sh`.
- Nella cartella `/openstreetmap-tile-server` eseguire `./launch-update-task.sh`

## Procedura di aggiornamento più veloce
Esiste una strategia più veloce che, invece di confrontare due versioni del database, estrae direttamente i changeset effettuati da una certa data e ora fino al presente. Questa procedura è stata implementata in `get-updates-by-time.sh`. Basta eseguire il comando con la seguente sintassi: `./get-updates-by-time.sh [data in formato yyyy-MM-dd_HH:mm:ss]` oppure `./get-updates-by-time.sh [inizio intervallo in yyyy-MM-dd_HH:mm:ss] [fine intervallo in yyyy-MM-dd_HH:mm:ss]`.

## Task periodico
Lo script `check-website-for-updates.sh` può essere invocato periodicamente con programmi tipo Crontab.
