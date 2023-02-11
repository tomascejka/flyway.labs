@echo off

REM
REM flyway and docker add specific jdbc driver via volume
REM as result see flyway:info output on standart output
REM
REM @author tomas.cejka
REM

call .\_var.bat

SET FLYWAY_DIR=C:\docker-volumes-data\labs\flyway
dir %FLYWAY_DIR%\data

docker run --rm -v %FLYWAY_DIR%\data:/flyway/sql -v %FLYWAY_DIR%\driver:/flyway/drivers flyway/flyway:%FLYWAY_VERSION% -url=jdbc:h2:mem:test -user=sa info