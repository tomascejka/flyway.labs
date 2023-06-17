# flyway mssql kubernetes pomoci initContainers
Cilem je mit vytvorenou tabulku ```Persons``` (detail nize) pomoci Flyway v mssql databazi ```flywaydb```, ktera bezi v kubernetes a to pomoci 'initContainers' (see deployment.yaml).

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
Sestavi se: docker images (flyway/mssql) a pak se vytvori prislusne kubernetes objekty pod(app+flyway) a pod/service(mssql). Pote se spusti na flyway pod-u/kontejneru prikaz ```flyway migrate```, který aplikuje skript (a založí tabulku ```Persons```).

```
$ kubectl get pods
NAME                                                    READY   STATUS    RESTARTS   AGE
echo-command-initcontainer-589bf8477-plv8s              1/1     Running   0          12m
flyway-mssql-kubernetes-initcontainer-c67dd645f-zwddv   1/1     Running   0          12m
```

## Test
Overime, zda v mssql databasi existuje tabulka, tzn. probehla uspesne migrace. Spustenim test.ps1 se mrkneme do logu app+flyway(je to az initContainer) pod-u, kt. vypisuje aktivitu o migraci:

```
2023-06-07 14:35:33 WARNING: This version of Flyway is out of date. Upgrade to Flyway 9.19.1: https://rd.gt/3rXiSlV
2023-06-07 14:35:33 
2023-06-07 14:35:33 Flyway Community Edition 9.16.1 by Redgate
2023-06-07 14:35:33 See release notes here: https://rd.gt/416ObMi
2023-06-07 14:35:33 
2023-06-07 14:35:33 Database: jdbc:sqlserver://flyway-mssql-kubernetes-initcontainer:1433;connectRetryInterval=10;connectRetryCount=1;maxResultBuffer=-1;sendTemporalDataTypesAsStringForBulkCopy=true;delayLoadingLobs=true;useFmtOnly=false;useBulkCopyForBatchInsert=false;cancelQueryTimeout=-1;sslProtocol=TLS;jaasConfigurationName=SQLJDBCDriver;statementPoolingCacheSize=0;serverPreparedStatementDiscardThreshold=10;enablePrepareOnFirstPreparedStatementCall=false;fips=false;socketTimeout=0;authentication=NotSpecified;authenticationScheme=nativeAuthentication;xopenStates=false;sendTimeAsDatetime=true;replication=false;trustStoreType=JKS;trustServerCertificate=true;TransparentNetworkIPResolution=true;serverNameAsACE=false;sendStringParametersAsUnicode=true;selectMethod=direct;responseBuffering=adaptive;queryTimeout=-1;packetSize=8000;multiSubnetFailover=false;loginTimeout=15;lockTimeout=-1;lastUpdateCount=true;encrypt=true;disableStatementPooling=true;databaseName=flywaydb;columnEncryptionSetting=Disabled;applicationName=Microsoft JDBC Driver for SQL Server;applicationIntent=readwrite; (Microsoft SQL Server 16.0)
2023-06-07 14:35:33 Schema history table [flywaydb].[dbo].[flyway_schema_history] does not exist yet
2023-06-07 14:35:33 Successfully validated 1 migration (execution time 00:00.199s)
2023-06-07 14:35:33 Creating Schema History table [flywaydb].[dbo].[flyway_schema_history] ...
2023-06-07 14:35:34 Current version of schema [dbo]: << Empty Schema >>
2023-06-07 14:35:34 Migrating schema [dbo] to version "1 - create person table"
2023-06-07 14:35:34 Successfully applied 1 migration to schema [dbo], now at version v1 (execution time 00:00.151s)
```