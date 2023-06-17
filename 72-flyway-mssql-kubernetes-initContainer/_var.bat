@echo off

SET regName=tocecz
SET appName=flyway-kubernetes-initcontainer
SET imgName=%regName%/%appName%
SET mssqlAppName=flyway-mssql-kubernetes-initcontainer
SET mssqlImgName=%regName%/%mssqlAppName%
SET ymlName=deployment.yaml
SET FLYWAY_VERSION=9.16-alpine
SET MSSQL_VERSION=2022-latest

echo -----------------------------------
echo %appName%
echo %imgName%
echo -----------------------------------

kubectl config use-context docker-desktop