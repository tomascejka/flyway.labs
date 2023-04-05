@echo off

call .\_var.bat

REM Download an image from a registry
REM see https://docs.docker.com/engine/reference/commandline/pull/
docker pull mcr.microsoft.com/mssql/server:2019-latest
docker pull flyway/flyway:%FLYWAY_VERSION%

REM -- build image for mssql (customized, init with database)
docker build -t %imgName% -f Dockerfile-mssql .