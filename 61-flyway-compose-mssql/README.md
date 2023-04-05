# flyway-compose-mssql
Příklad, který presentuje start mssql serveru s prázdnou databází a poté spuštění kontejneru s flyway nástrojem (pro versování databázových schémat) nicméně zde již via docker compose. 

## Prerequisites
Nainstalovaný docker engine/cli, např. docker desktop.

## Build
Spusťte skript ```build.bat```, který stáhne docker image mssql/flyway serveru a mssql image upraví, aby pracoval s init skriptem (kt. vytvoří prázdnou databási ```flywaydb``` - bez ní nelze jakýkoli ```flyway``` příkaz spustit). Výsledek si ověřte ```docker images``` a:

```
REPOSITORY                                      TAG             IMAGE ID       CREATED        SIZE
tocecz/flyway-compose-mssql                     latest          20ccb7ce60ac   9 minutes ago  1.47GB
flyway/flyway                                   latest-alpine   4f74399ce872   7 days ago     383MB
mcr.microsoft.com/mssql/server                  latest          9e28798be691   3 months ago   1.6GB
```

## Run
Spusť ```run.bat``` , který nastartuje docker compose. A ten se již postará o start obou kontejnerů (mssql a flyway) ve správném pořadí. Po nastartování ```flyway``` kontejneru provede příkaz ```flyway info```, který vypíše stav skriptu v ```C:\docker-volumes-data\labs\flyway\mssql-compose\data``` (připojené jako volume) proti běžícícímu kontejneru s mssql databází.

```
flyway-compose-cli    | Flyway Community Edition 9.14.1 by Redgate
flyway-compose-cli    | See what's new here: https://flywaydb.org/documentation/learnmore/releaseNotes#9.14.1
flyway-compose-cli    |
flyway-compose-cli    | Database: jdbc:sqlserver://localhost:1433;connectRetryInterval=10;connectRetryCount=1;maxResultBuffer=-1;sendTemporalDataTypesAsStringForBulkCopy=true;delayLoadingLobs=true;useFmtOnly=false;useBulkCopyForBatchInsert=false;cancelQueryTimeout=-1;sslProtocol=TLS;jaasConfigurationName=SQLJDBCDriver;statementPoolingCacheSize=0;serverPreparedStatementDiscardThreshold=10;enablePrepareOnFirstPreparedStatementCall=false;fips=false;socketTimeout=0;authentication=NotSpecified;authenticationScheme=nativeAuthentication;xopenStates=false;datetimeParameterType=datetime2;sendTimeAsDatetime=true;replication=false;trustStoreType=JKS;trustServerCertificate=true;TransparentNetworkIPResolution=true;iPAddressPreference=IPv4First;serverNameAsACE=false;sendStringParametersAsUnicode=true;selectMethod=direct;responseBuffering=adaptive;queryTimeout=-1;packetSize=8000;multiSubnetFailover=false;loginTimeout=30;lockTimeout=-1;lastUpdateCount=true;prepareMethod=prepexec;encrypt=True;disableStatementPooling=true;databaseName=flywaydb;columnEncryptionSetting=Disabled;applicationName=Microsoft JDBC Driver for SQL Server;applicationIntent=readwrite; (Microsoft SQL Server 15.0)
flyway-compose-cli    | Schema version: << Empty Schema >>
flyway-compose-cli    |
flyway-compose-cli    | +-----------+---------+---------------------+------+--------------+---------+----------+
flyway-compose-cli    | | Category  | Version | Description         | Type | Installed On | State   | Undoable |
flyway-compose-cli    | +-----------+---------+---------------------+------+--------------+---------+----------+
flyway-compose-cli    | | Versioned | 2       | Create person table | SQL  |              | Pending | No       |
flyway-compose-cli    | | Versioned | 3       | Add people          | SQL  |              | Pending | No       |
flyway-compose-cli    | +-----------+---------+---------------------+------+--------------+---------+----------+
```

## Sources
- https://documentation.red-gate.com/fd/tutorial-using-flyway-check-with-sql-server-184127628.html << presents check command (only in Enterprise version) but there are presented docker/flyway also
- https://dotnetthoughts.net/initialize-mssql-in-docker-container/ << jak spustit sql při startu mssql kontejneru
- https://flywaydb.org/documentation/usage/commandline/
- https://hub.docker.com/r/flyway/flyway
- https://github.com/flyway/flyway-docker
- https://juergenpointinger.github.io/use-flyway-with-docker/