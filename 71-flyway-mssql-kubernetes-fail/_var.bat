@echo off

SET regName=tocecz
SET appName=flyway-kubernetes-fail
SET appNameFail=flyway-kubernetes-fail-koscript
SET imgName=%regName%/%appName%
SET imgNameFail=%regName%/%appNameFail%
SET mssqlAppName=flyway-kubernetes-fail-mssql
SET mssqlImgName=%regName%/%mssqlAppName%

SET FLYWAY_VERSION=9.16-alpine
SET MSSQL_VERSION=2022-latest

echo -----------------------------------
echo %appName%
echo %imgName%
echo --
echo %appNameFail%
echo %imgNameFail%
echo -----------------------------------

kubectl config use-context docker-desktop