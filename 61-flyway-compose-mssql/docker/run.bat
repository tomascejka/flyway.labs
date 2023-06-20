@echo off

call .\_var.bat

echo.
SET /P opt=Spustit i mssql server?, eg. y:
echo.

SET HOST_PORT=1433
SET FLYWAY_PASSWORD=Flyway123

REM -- spusti mssql databasi
IF [%opt%] EQU [y] (
	echo ---------------------------------------------
	echo Spusti mssql kontejner
	echo ---------------------------------------------
	docker run --rm --name %appName% -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=%FLYWAY_PASSWORD%" -p %HOST_PORT%:1433 -d %imgName%
	echo pockam 30s... start mssql serveru
	TIMEOUT /T 30
)

REM -- zobrazi, seznam databasi jedna z nich MUSI byt flywaydb!
echo ---------------------------------------------
echo Seznam databasi v mssql kontejneru
echo ---------------------------------------------
docker exec -it %appName% /opt/mssql-tools/bin/sqlcmd -S "localhost,%HOST_PORT%" -U SA -P "%FLYWAY_PASSWORD%" -Q "select name from sys.databases"
pause

REM -- spusti flyway, konfigurace mssql server je v conf/flyway.conf
echo ---------------------------------------------
echo Spusti FLYWAY - info prikaz
echo ---------------------------------------------
REM SET FLYWAY_DIR=C:\docker-volumes-data\labs\flyway\mssql
SET FLYWAY_DIR=.\src\flyway

REM docker run --rm --network="host" ^
REM   -v %FLYWAY_DIR%\data:/flyway/sql ^
REM   -v %FLYWAY_DIR%\driver:/flyway/drivers ^
REM   -v %FLYWAY_DIR%\conf:/flyway/conf ^
REM   flyway/flyway:%FLYWAY_VERSION% info

REM docker run --rm --name="%FLYWAY_APPNAME%" --network="host" ^
REM     -v %FLYWAY_DIR%\data:/flyway/sql ^
REM     -v %FLYWAY_DIR%\conf:/flyway/conf ^
REM     %FLYWAY_IMGNAME% info

docker run --rm --name="%FLYWAY_APPNAME%" --network="host" ^
    -v %FLYWAY_DIR%\data:/flyway/sql ^
    -e FLYWAY_USER=sa ^
    -e FLYWAY_PASSWORD=%FLYWAY_PASSWORD% ^
 	-e FLYWAY_URL=jdbc:sqlserver://localhost:%HOST_PORT%;databaseName=flywaydb;trustServerCertificate=true ^
 	%FLYWAY_IMGNAME% info