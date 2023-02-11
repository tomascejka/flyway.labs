@echo off

REM
REM flyway and docker additional configuration approach via external file flyway.conf
REM as result see flyway:info output on standart output
REM
REM @author tomas.cejka
REM

call .\_var.bat

SET FLYWAY_DIR=C:\docker-volumes-data\labs\flyway
dir %FLYWAY_DIR%\data

docker run --rm -v %FLYWAY_DIR%\data:/flyway/sql -v %FLYWAY_DIR%\conf:/flyway/conf flyway/flyway:%FLYWAY_VERSION% info