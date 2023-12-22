# Gestire più database OSM

Supponiamo di voler mettere in piedi _n_ basi di dati di OSM, ognuna con una propria mappa e un tile server accoppiato, e che siano accessibili e modificabili con l'editor iD.
Inoltre nell'interfaccia deve essere presente un controller che permette all'editor di cambiare il database di lavoro in tempo reale.

## Una possibile soluzione
Innanzitutto bisogna inizializzare le _n_ istanze del docker-compose, in quanto ogni istanza deve avere:

- Il servizio `db`, cioè il container del database Postgres
- Il servizio `map`, che è il container del tile server
- Il servizio `web`, ovvero il container del sito web e dell'editor iD.

### È proprio necessario il servizio _web_?
Si perché, oltre a far visualizzare e modificare la mappa, questo servizio espone anche un'API HTTP che è fondamentale per iD o per qualunche altro editor.  

A questo punto si può procedere in due modi:

### Modo 1
Pagina web che permette di scegliere a quale editor collegarsi bla bla bla

### Modo 2
Modificare iD ancora bla bla bla


## Fonti
1. https://github.com/openstreetmap/iD/issues/4288 - Switching server while loading causes glitchy behavior
2. https://github.com/openstreetmap/iD/issues/4405 - Allow switching of servers on preview.ideditor.com
3. https://github.com/openstreetmap/openstreetmap-website/pull/3792 - Hide live/dev server switcher on integrated iD editor
