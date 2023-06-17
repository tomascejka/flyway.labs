# flyway mssql kubernetes
Cilem je mit vytvorenou tabulku ```Persons``` (detail nize) pomoci Flyway v mssql databazi ```flywaydb```, ktera bezi v kubernetes.

```
CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);
```

## Build
Sestavi se: docker images (flyway/mssql) a pak se vytvori prislusne kubernetes objekty job(flyway) a pod/service(mssql). Pote se spusti na flyway pod-u/kontejneru prikaz ```flyway migrate```, který aplikuje skript (a založí tabulku ```Persons```).

```
---------------------------------------------
List of build images
---------------------------------------------
tocecz/flyway-kubernetes-gs-v1         latest    8ed4d53f2b9f   6 minutes ago       384MB
tocecz/flyway-mssql-kubernetes-gs-v1   latest    bfbe9818c09a   About an hour ago   1.61GB

---------------------------------------------
List of kubernetes objects
---------------------------------------------
deployment.apps/flyway-mssql-kubernetes-gs created
service/flyway-mssql-kubernetes-gs-v1 created

Waiting for  0 seconds, press a key to continue ...
job.batch/flyway-job created
```

## Test
Overime, zda v mssql databasi existuje tabulka, tzn. probehla uspesne migrace. Spustenim test.ps1 se mrkneme do logu flyway pod-u, kt. vypisuje aktivitu o migraci:

```
2023-04-13 09:43:22 WARNING: This version of Flyway is out of date. Upgrade to Flyway 9.16.3: https://rd.gt/3rXiSlV
2023-04-13 09:43:22 
2023-04-13 09:43:22 Flyway Community Edition 9.16.1 by Redgate
2023-04-13 09:43:22 See release notes here: https://rd.gt/416ObMi
2023-04-13 09:43:22 
2023-04-13 09:43:22 Database: jdbc:sqlserver://flyway-mssql-kubernetes-gs-v1:1433;connectRetryInterval=10;connectRetryCount=1;maxResultBuffer=-1;sendTemporalDataTypesAsStringForBulkCopy=true;delayLoadingLobs=true;useFmtOnly=false;useBulkCopyForBatchInsert=false;cancelQueryTimeout=-1;sslProtocol=TLS;jaasConfigurationName=SQLJDBCDriver;statementPoolingCacheSize=0;serverPreparedStatementDiscardThreshold=10;enablePrepareOnFirstPreparedStatementCall=false;fips=false;socketTimeout=0;authentication=NotSpecified;authenticationScheme=nativeAuthentication;xopenStates=false;sendTimeAsDatetime=true;replication=false;trustStoreType=JKS;trustServerCertificate=true;TransparentNetworkIPResolution=true;serverNameAsACE=false;sendStringParametersAsUnicode=true;selectMethod=direct;responseBuffering=adaptive;queryTimeout=-1;packetSize=8000;multiSubnetFailover=false;loginTimeout=15;lockTimeout=-1;lastUpdateCount=true;encrypt=true;disableStatementPooling=true;databaseName=flywaydb;columnEncryptionSetting=Disabled;applicationName=Microsoft JDBC Driver for SQL Server;applicationIntent=readwrite; (Microsoft SQL Server 16.0)
2023-04-13 09:43:22 Schema history table [flywaydb].[dbo].[flyway_schema_history] does not exist yet
2023-04-13 09:43:22 Successfully validated 1 migration (execution time 00:00.126s)
2023-04-13 09:43:22 Creating Schema History table [flywaydb].[dbo].[flyway_schema_history] ...
2023-04-13 09:43:22 Current version of schema [dbo]: << Empty Schema >>
2023-04-13 09:43:22 Migrating schema [dbo] to version "1 - create person table"
2023-04-13 09:43:22 Successfully applied 1 migration to schema [dbo], now at version v1 (execution time 00:00.072s)
```