@echo off

call .\_var.bat

REM Download an image from a registry
REM see https://docs.docker.com/engine/reference/commandline/pull/
docker pull mcr.microsoft.com/mssql/server
docker pull flyway/flyway:latest-alpine