@echo off

REM
REM flyway and docker using simplest way to presentation via h2 in memory
REM as result see flyway:info output on standart output
REM
REM @author tomas.cejka
REM

call .\_var.bat

SET FLYWAY_DIR=C:\docker-volumes-data\labs\flyway
dir %FLYWAY_DIR%\data

docker run --rm -v %FLYWAY_DIR%\data:/flyway/sql flyway/flyway:%FLYWAY_VERSION% -url=jdbc:h2:mem:test -user=sa info