@echo off

SET regName=tocecz
SET appName=flyway-kubernetes-gs-v1
SET imgName=%regName%/%appName%
SET mssqlAppName=flyway-mssql-kubernetes-gs-v1
SET mssqlImgName=%regName%/%mssqlAppName%
SET ymlName=job.yaml
SET FLYWAY_VERSION=9.16-alpine
SET MSSQL_VERSION=2022-latest

echo -----------------------------------
echo %appName%
echo %imgName%
echo -----------------------------------

kubectl config use-context docker-desktop