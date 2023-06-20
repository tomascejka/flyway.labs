@echo off

SET appName=flyway-docker-mssql
SET imgName=tocecz/%appName%
SET MSSQL_VERSION=2022-latest

SET FLYWAY_APPNAME=flyway-docker-v1
SET FLYWAY_IMGNAME=tocecz/%FLYWAY_APPNAME%
SET FLYWAY_VERSION=9.14.1-alpine

echo -----------------------------------
echo %appName%
echo %imgName%
echo -----------------------------------