# flyway-docker-configured
How to start with flyway (using h2 in memory) in docker and presents how to using configuration via external file flyway.conf. 

## Build
Spusť skript ```build.bat```, který stáhne flyway oficialni docker image do tvého lokalniho docker repositáře.

## Run
Spusť skript ```run.bat```, který nalinkuje (lokální) adresář s sql skripty - jako volume a provolá flyway:info příkaz. Příkaz vypíše stav sql skriptů proti databázi (pro jednoduchost se používá - h2 v paměti).

## Sources
- https://flywaydb.org/documentation/usage/commandline/
- https://hub.docker.com/r/flyway/flyway
- https://github.com/flyway/flyway-docker
- https://juergenpointinger.github.io/use-flyway-with-docker/