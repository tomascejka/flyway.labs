@echo off

call .\_var.bat

REM Download an image from a registry
REM see https://docs.docker.com/engine/reference/commandline/pull/
REM docker pull mcr.microsoft.com/mssql/server:2019-latest
REM docker pull flyway/flyway:%FLYWAY_VERSION%

REM -- build image for mssql (customized, init with database)
docker build --build-arg MSSQL_VERSION=%MSSQL_VERSION% -t %imgName% -f Dockerfile-mssql .

docker build --build-arg FLYWAY_VERSION=%FLYWAY_VERSION% -t %FLYWAY_IMGNAME% -f Dockerfile .
