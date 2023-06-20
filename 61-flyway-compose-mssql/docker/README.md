# flyway-docker-mssql v docker compose
Příklad, který presentuje start mssql serveru s prázdnou databází a poté spuštění kontejneru s flyway nástrojem (pro versování databázových schémat) - tentokrate v docker compose. 

## Prerequisites
Nainstalovaný docker engine/cli, např. docker desktop.

## Build
Spusťte skript ```build.bat```, který stáhne docker image mssql/flyway serveru a mssql image upraví, aby pracoval s init skriptem (kt. vytvoří prázdnou databási ```flywaydb``` - bez ní nelze flyway příkaz spustit). 

## Run
Spusť ```run.bat``` a nastartuje kontejner s mssql server-em (+ spustí časovač na několik sekund) - poté se spustí ```docker exec``` s kontrolním sql dotazem na seznam databází (vypíše se i ta naše ```flywaydb```). Zde se skript zastaví a čeká se na spuštění uživatelem... odpausnutím se spustí docker kontejner s flyway-em a příkazem  ```flyway info```, kterým presentuji kooperaci těchto nástrojů dohromady.

## Sources
- https://documentation.red-gate.com/fd/tutorial-using-flyway-check-with-sql-server-184127628.html << presents check command (only in Enterprise version) but there are presented docker/flyway also
- https://dotnetthoughts.net/initialize-mssql-in-docker-container/ << jak spustit sql při startu mssql kontejneru
- https://flywaydb.org/documentation/usage/commandline/
- https://hub.docker.com/r/flyway/flyway
- https://github.com/flyway/flyway-docker
- https://juergenpointinger.github.io/use-flyway-with-docker/